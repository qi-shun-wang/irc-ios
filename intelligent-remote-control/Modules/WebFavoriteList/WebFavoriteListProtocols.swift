//
//  WebFavoriteListProtocols.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/14.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

protocol Content {
    
}

protocol File:Content {}
protocol Folder:Content {}
protocol Blank:Content{}
class WebsiteBlank:Blank{}
class FavoriteWebsites {
    static let share = FavoriteWebsites()
    private(set) var folders = [WebsiteFolder]()
    
    // MARK: Identifier Lookups
    func folder(for identifier: UUID) -> WebsiteFolder? {
        return folders.first(where: { file in file.identifier == identifier })
    }
    
    func file(for identifier: UUID) -> WebsiteFile? {
        let folder = folders.first(where: { folder in
            folder.files.contains(where: { file in file.identifier == identifier })
        })
        return folder?.files.first(where: { file in file.identifier == identifier })
    }
    
    
    // MARK: Favorite Websites Mutations
    
    /// Adds a file to the folder.
    func add(_ file: WebsiteFile, to folder: WebsiteFolder) {
        guard let folderIndex = folders.index(of: folder) else { return }
        
        folders[folderIndex].files.insert(file, at: 0)
    }
    
    /// Inserts the file at a specific index in the folder.
    func insert(_ file: WebsiteFile, into folder: WebsiteFolder, at index: Int) {
        guard let folderIndex = folders.index(of: folder) else { return }
        
        folders[folderIndex].files.insert(file, at: index)
    }
    
    /// Moves an folder from one index to another.
    func moveFolder(at sourceIndex: Int, to destinationIndex: Int) {
        let folder = folders[sourceIndex]
        folders.remove(at: sourceIndex)
        folders.insert(folder, at: destinationIndex)
    }
    
    /// Moves a file from one index to another in the folder.
    func moveFile(in folder: WebsiteFolder, from sourceIndex: Int, to destinationIndex: Int) {
        guard let folderIndex = folders.index(of: folder) else { return }
        
        let file = folders[folderIndex].files[sourceIndex]
        folders[folderIndex].files.remove(at: sourceIndex)
        folders[folderIndex].files.insert(file, at: destinationIndex)
    }
    
    /// Moves a file to a different folder at a specific index in that folder. Defaults to inserting at the beginning of the folder if no index is specified.
    func moveFile(_ file: WebsiteFile, to folder: WebsiteFolder, index: Int = 0) {
        guard let sourceAlbumIndex = folders.index(where: { folder in folder.files.contains(file) }),
            let indexOfPhotoInSourceAlbum = folders[sourceAlbumIndex].files.index(of: file),
            let destinationAlbumIndex = folders.index(of: folder)
            else { return }
        
        let file = folders[sourceAlbumIndex].files[indexOfPhotoInSourceAlbum]
        folders[sourceAlbumIndex].files.remove(at: indexOfPhotoInSourceAlbum)
        folders[destinationAlbumIndex].files.insert(file, at: index)
    }
    
    // MARK: Timed Automatic Insertions
    
    private var folderForAutomaticInsertions: WebsiteFolder?
    private var automaticInsertionTimer: Timer?
    
    /// Starts a timer that performs an automatic insertion of a file into the folder when it fires.
//    func startAutomaticInsertions(into folder: WebsiteFolder, photoCollectionViewController: PhotoCollectionViewController) {
//        stopAutomaticInsertions()
//        folderForAutomaticInsertions = folder
//        automaticInsertionTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
//            guard let folder = self.folderForAutomaticInsertions, let folderIndex = self.folders.index(of: folder) else { return }
//            let image: UIImage = #imageLiteral(resourceName: "AutomaticInsertion.png")
//            let file = WebsiteFile(image: image)
//            let insertionIndex = Int(arc4random_uniform(UInt32(self.folders[folderIndex].files.count)))
//            self.folders[folderIndex].files.insert(file, at: insertionIndex)
//            photoCollectionViewController.insertedItem(at: insertionIndex)
//        })
//    }
    
    /// Stops the timer that performs automatic insertions.
    func stopAutomaticInsertions() {
        folderForAutomaticInsertions = nil
        automaticInsertionTimer?.invalidate()
        automaticInsertionTimer = nil
    }
    
    // MARK: Initialization and Loading Sample Data
    
    init() {
        self.loadSampleData()
    }
    
    private func loadSampleData() {
        var folderIndex = 0
        var foundFolder: Bool
        repeat {
            foundFolder = false
            var files = [WebsiteFile]()
            
            var photoIndex = 0
            var foundPhoto: Bool
            repeat {
                foundPhoto = false
                let imageName = "Folder\(folderIndex)File\(photoIndex).jpg"
                if let image = UIImage(named: imageName) {
                    foundPhoto = true
                    let file = WebsiteFile(image: image,url:"")
                    files.append(file)
                }
                photoIndex += 1
            } while foundPhoto
            
            if !files.isEmpty {
                foundFolder = true
                let title = "Folder \(folderIndex + 1)"
                let folder = WebsiteFolder(title: title, files: files,image: UIImage())
                folders.append(folder)
            }
            folderIndex += 1
        } while foundFolder
    }

    
}
struct WebsiteFile:File {
    let identifier = UUID()
    var image: UIImage
    var url:String
    
}

extension WebsiteFile: Equatable {
    static func ==(lhs: WebsiteFile, rhs: WebsiteFile) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

struct WebsiteFolder:Folder {
    let identifier = UUID()
    var title = ""
    var files = [WebsiteFile]()
    var image: UIImage
    
    func contains(file: WebsiteFile) -> Bool {
        return files.contains(file)
    }
        
}
extension WebsiteFolder: Equatable {
    static func ==(lhs: WebsiteFolder, rhs: WebsiteFolder) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

protocol WebFavoriteListViewProtocol: class
{
    var presenter:WebFavoriteListPresenterProtocol?{get set}
    ///called presenter's viewDidLoad() will perform the setups below:
    func setupNavigationLeftItem(image named:String)
    func setupNavigationRightItem(with title:String)
    func setupNavigationTitle(with text:String)
    /// displays what it is told to by the Presenter and relays user input back to the Presenter.
    func hideLoading()
    func showLoading()
    func showError()
//    func showFavoriteList(with websites: [Int:[WebsiteModel]])
}

protocol WebFavoriteListPresenterProtocol: class
{
    var view:WebFavoriteListViewProtocol?{get set}
    var router:WebFavoriteListRoutingProtocol?{get set}
    var interactor:WebFavoriteListInteraterInputProtocol?{get set}
    
    func viewDiDLoad()
    func addFolder()
    func deleteHistory(for website:WebsiteModel)
}

protocol WebFavoriteListRoutingProtocol: class
{
    static func createFavoriteListModule() -> UIViewController
}

protocol WebFavoriteListInteraterInputProtocol: class
{
    var presenter:WebFavoriteListInteraterOutputProtocol?{get set}
    var localDataManager:WebFavoriteListLocalDataManagerInputProtocol?{get set}
}

protocol WebFavoriteListInteraterOutputProtocol: class
{
    
}

protocol WebFavoriteListLocalDataManagerInputProtocol: class
{
    
}
