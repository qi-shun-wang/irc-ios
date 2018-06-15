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
    var assets: PHFetchResult<PHAsset>?
    var worker:Timer?
    var photoSize:Size?
    var selectedPhotoIndexes = [IndexPath]()
    var currentIndex:Int = 0
   
}

extension MediaSharePhotosPresenter: MediaSharePhotosPresentation {
    
    func viewWillAppear() {
        
    }
    
    func viewWillDisappear() {
        interactor?.performRemoteStop()
    }
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupMediaControlToolBar(text: "")
        view?.setupWarningBadge()
        view?.setupMediaControlToolBar(imageName: "media_share_cast_icon")
        photoSize = view?.fetchedPhotoSize()
        interactor?.checkPhotoPermission()
    }
    
    func itemInfo(at indexPath: IndexPath, _ isSelected: @escaping (Bool) -> Void, _ resultHandler: @escaping (Image?, [AnyHashable : Any]?) -> Void) {
        
        guard let asset = assets?[indexPath.item] else {return resultHandler(nil,nil)}
        
        let isPhotoSelected = (selectedPhotoIndexes.index(of: indexPath) != nil)
        isSelected(isPhotoSelected)
        
        PHImageManager.default().requestImage(for: asset, targetSize: photoSize as! CGSize, contentMode: .aspectFill, options: nil, resultHandler: resultHandler)
        
    }
    
    func numberOfItems(in section: Int) -> Int {
        return assets?.count ?? 0
    }
    
    func performCastAction() {
        if selectedPhotoIndexes.count == 0 {
            view?.showWarningBadge(with: "至少選一張圖片!")
            return
        }
        currentIndex = 0
        router?.presentDMRList()
    }
    
    func checkingConnectedDevice() {
        interactor?.checkConnectionStatus()
    }
    
    func didSelectItem(at indexPath: IndexPath) -> Bool {
        interactor?.performRemoteStop()
        
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
        assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
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
        view?.showWarningBadge(with: "正在準備推送圖片...")
        var selectedAssets:[ImageAsset] = []
        for selectedIndex in selectedPhotoIndexes {
            guard let asset = assets?[selectedIndex.item] else {return}
            selectedAssets.append(asset)
        }
        interactor?.setupSelectedPhotos(assets: selectedAssets)
        interactor?.setupCurrentRemoteAsset(at: 0)
        print(device)
    }
    
    func deviceNotConnect() {
        view?.showWarningBadge(with: "請選擇媒體播放設備!")
    }
    
    func didSetRemoteAssetSuccess() {
        interactor?.performRemotePlay()
    }
    
    func didSetRemoteAssetFailure() {
        
    }
    
    func didPlayRemoteAssetSuccess() {
           view?.hideWarningBadge(with: "推送成功!")
        if selectedPhotoIndexes.count - 1 > currentIndex {
            currentIndex += 1
         
            Timer.scheduledTimer(withTimeInterval: 10.0, repeats: false) { (timer) in
                self.interactor?.setupCurrentRemoteAsset(at: self.currentIndex)
            }
        }
    }
    
    func didPlayRemoteAssetFailure() {
        
    }
    
    func didStopRemoteAssetFailure() {
        
    }
}
