//
//  EditFolderPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/25.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class EditFolderPresenter {
    
    // MARK: Properties
   fileprivate var tmpCategories:[WebsiteCategory] = []
   fileprivate var categories:[WebsiteCategory] = [
        WebsiteCategory(id: 0, level:0,name: "我的分類", url: "", icon: "web_bookmark_folder_icon"),
        WebsiteCategory(id: 1, level:1,name: "的分類", url: "", icon: "web_bookmark_folder_icon"),
        WebsiteCategory(id: 2, level:2,name: "分類", url: "", icon: "web_bookmark_folder_icon"),
        WebsiteCategory(id: 3, level:3,name: "類", url: "", icon: "web_bookmark_folder_icon"),
        WebsiteCategory(id: 4, level:0,name: "你的分類", url: "", icon: "web_bookmark_folder_icon"),
        WebsiteCategory(id: 5, level:1,name: "的分類", url: "", icon: "web_bookmark_folder_icon"),
        WebsiteCategory(id: 6, level:2,name: "分類", url: "", icon: "web_bookmark_folder_icon"),
        WebsiteCategory(id: 7, level:3,name: "類", url: "", icon: "web_bookmark_folder_icon"),
        WebsiteCategory(id: 8, level:0,name: "她的分類", url: "", icon: "web_bookmark_folder_icon"),
        WebsiteCategory(id: 9, level:1,name: "的分類", url: "", icon: "web_bookmark_folder_icon"),
        WebsiteCategory(id: 10, level:2,name: "分類", url: "", icon: "web_bookmark_folder_icon"),
        WebsiteCategory(id: 11, level:3,name: "類", url: "", icon: "web_bookmark_folder_icon"),
        
        ]
    fileprivate var currentFolder:WebsiteCategory!
    fileprivate var isExpanded:Bool = false
    
    weak var view: EditFolderView?
    var router: EditFolderWireframe?
    var interactor: EditFolderUseCase?
}

extension EditFolderPresenter: EditFolderPresentation {
    
    func viewWillAppear() {
        
    }
    
    func viewWillDisappear() {
        
    }
    
    func didSelect(at indexPath: IndexPath) {
        if indexPath.section == 1 {
            view?.dismissKeyboard()
            if !isExpanded {
                expandingTable()
            } else {
                currentFolder = categories[ indexPath.row]
                shrinkingTable()
            }
        }
    }
    
    func expandingTable() {
        isExpanded = true
        let insertPaths:[IndexPath] = categories.enumerated().map(){ i,_ in return IndexPath(row: i, section: 1)}
        let deletePaths:[IndexPath] = [IndexPath(row:0,section:1)]
        tmpCategories = categories
        view?.expandingTable(with: deletePaths, insertPaths)
    }
    
    func shrinkingTable() {
        if isExpanded {
            let deletePaths:[IndexPath] = categories.enumerated().map(){ i,_ in return IndexPath(row: i, section: 1)}
            let insertPaths:[IndexPath] = [IndexPath(row:0,section:1)]
            isExpanded = false
            tmpCategories = [currentFolder]
            view?.shrinkingTable(with: deletePaths, insertPaths)
        }
    }
    
    func viewDidLoad() {
        currentFolder = WebsiteCategory(id: 0, level:0,name: "我的分類", url: "", icon: "web_bookmark_folder_hightlight_icon")
        tmpCategories = [currentFolder]
        view?.setupNavigationBarStyle()
        view?.setupNavigationTitle(with:"編輯文件夾")
    }
    
    func setupCurentFolder(at index:Int){
        currentFolder = categories[index]
    }
    
    func titleForHeader(in section:Int) -> String? {
        if section == 1 {return "位置"}
        return nil
    }
    
    func heightForHeader(in section:Int) -> Float {
        if section == 0 {
            return 60
        }
        return 20
    }
    
    func heightForRooter(in section:Int) -> Float {
        if section == 0 {
            return 60
        }
        return 0
    }
    
    func numberOfRows(in section:Int) -> Int {
        if section == 0 {
            return 1
        }
        return tmpCategories.count
    }
    
    func numberOfSections() -> Int{
        return  2
    }
    
    func cellInfoForRow(at indexPath:IndexPath) -> (identifier:String,text:String,icon:String,indentationLevel:Int,indentationWidth:Float) {
        if indexPath.section == 0 {
            return ("EditFolderNameCell","","",0,0.0)
        }else {
            let category = tmpCategories[indexPath.row]
            
            return (
                "EditFolderLocationCell",
                category.name,
                category == currentFolder ? "web_bookmark_folder_hightlight_icon" : category.icon ,
                category.level,
                isExpanded ? 10 : 0
            )
        }
    }
    
}

extension EditFolderPresenter: EditFolderInteractorOutput {
    // TODO: implement interactor output methods
}
