//
//  MediaSharePhotosPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import Photos

class MediaSharePhotosPresenter {
    
    // MARK: Properties
    weak var view: MediaSharePhotosView?
    var router: MediaSharePhotosWireframe?
    var interactor: MediaSharePhotosUseCase?
    
    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult<PHAsset>?
    
    var photoSize:Size?
    var selectedPhotoIndexes = [IndexPath]()
    var nextIndex:Int = 0
    let worker:Worker = Worker()
    var isStop:Bool = false
    var hasNext:Bool {
        get {
            return selectedPhotoIndexes.count > 1 && nextIndex < selectedPhotoIndexes.count - 1 && !isStop
        }
    }
    
    fileprivate func performCast(){
        guard let photosAsset = photosAsset else {return}
        interactor?.checkConnectionStatus()
        guard selectedPhotoIndexes.count > nextIndex else {return}
        guard photosAsset.count > selectedPhotoIndexes[nextIndex].item else {return}
        worker.run(in: 3) { () -> (Void) in
            print(self.nextIndex)
            if self.isStop {return}
            self.interactor?.castSelectedImage(photosAsset[self.selectedPhotoIndexes[self.nextIndex].item])
        }
    }
}

extension MediaSharePhotosPresenter: MediaSharePhotosPresentation {
   
    func performImageCast() {
        performCast()
    }
    
    func itemInfo(at indexPath: IndexPath, _ isSelected: @escaping (Bool) -> Void, _ resultHandler: @escaping (Image?, [AnyHashable : Any]?) -> Void) {
        
        guard let asset = photosAsset?[indexPath.item] else {return resultHandler(nil,nil)}
        
        let isPhotoSelected = (selectedPhotoIndexes.index(of: indexPath) != nil)
        isSelected(isPhotoSelected)
       
        PHImageManager.default().requestImage(for: asset, targetSize: photoSize as! CGSize, contentMode: .aspectFill, options: nil, resultHandler: resultHandler)

    }
    
    func numberOfItems(in section: Int) -> Int {
        return photosAsset?.count ?? 0
    }
    
    func stopImageCast() {
        interactor?.stopCasting()
    }
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupMediaControlToolBar(text: "開始投放圖片")
        view?.setupWarningBadge()
        photoSize = view?.fetchedPhotoSize()
        interactor?.checkPhotoPermission()
        
        
    }
    
    func setupAssetFetchOptions(){
       
        
    }
    
    func didSelectItem(at indexPath: IndexPath) -> Bool {
        interactor?.stopCasting()
        nextIndex = 0
        if let index = selectedPhotoIndexes.index(of: indexPath) {
            selectedPhotoIndexes.remove(at: index)
            return false
        } else {
            selectedPhotoIndexes.append(indexPath)
            return true
        }
        
    }
    
}

extension MediaSharePhotosPresenter: MediaSharePhotosInteractorOutput {
    func successAuthorizedPermission() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.includeAssetSourceTypes = .typeUserLibrary
        photosAsset = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        DispatchQueue.main.async {
            self.view?.reloadPhotosCollectionView()
        }
    }
    
    func failureAuthorizedPermission() {
        
    }
    
    func didConnected(_ device: DMR) {
        isStop = false
        print(device)
    }
    func willStartNext() {
        if hasNext {
            performCast()
            nextIndex += 1
        } 
    }
    
    func deviceNotConnect() {
        router?.presentDMRList()
        isStop = true
    }
    func didStartCasting() {
        
    }
    func didStopedCasting() {
        isStop = true
        view?.setupMediaControlToolBar(text: "開始投放圖片")
    }
}
