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
        //check whether has selected image
        if selectedPhotoIndexes.count == 0 {
            view?.showWarningBadge(with: "至少選一張圖片!")
            return
        }
        router?.presentDMRList()
    }
    
    func checkingConnectedDevice() {
        interactor?.checkConnectionStatus()
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
        view?.setupMediaControlToolBar(text: "")
        view?.setupWarningBadge()
        view?.setupMediaControlToolBar(imageName: "media_share_cast_icon")
        photoSize = view?.fetchedPhotoSize()
        interactor?.checkPhotoPermission()
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
            self.view?.hideTips()
            self.view?.reloadPhotosCollectionView()
        }
    }
    
    func failureAuthorizedPermission() {
        DispatchQueue.main.async {
            self.view?.showTips()
        }
    }
    
    func didConnected(_ device: DMR) {
        isStop = false
        performCast()
        view?.showWarningBadge(with: "正在準備推送圖片...")
        print(device)
    }
    
    func willStartNext() {
        view?.hideWarningBadge(with: "推送成功!")
        if hasNext {
            performCast()
            nextIndex += 1
        } 
    }
    
    func deviceNotConnect() {
        view?.showWarningBadge(with: "請選擇媒體播放設備!")
        isStop = true
    }
    
    func didStartCasting() {
        
    }
    
    func didStopedCasting() {
        isStop = true
    }
}
