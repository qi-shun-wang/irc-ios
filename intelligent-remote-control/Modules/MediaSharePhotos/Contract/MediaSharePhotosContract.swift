//
//  MediaSharePhotosContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol MediaSharePhotosView: BaseView {
    
    func setupMediaControlToolBar(text:String)
    func setupMediaControlToolBar(imageName:String)
    func fetchedPhotoSize() -> Size?
    func reloadPhotosCollectionView()
    func showTips()
    func hideTips()
}

protocol MediaSharePhotosPresentation: BasePresentation {
    
    func didSelectItem(at indexPath: IndexPath)->(Bool)
    func numberOfItems(in section:Int) -> Int
    func itemInfo(at indexPath:IndexPath,_ isSelected:@escaping (Bool) -> Void, _ resultHandler: @escaping (Image?,[AnyHashable:Any]?)->Void)
    func checkingConnectedDevice()
    func performCastAction()
    
}

protocol MediaSharePhotosUseCase: class {
    func checkPhotoPermission()
    func checkConnectionStatus()
 
    func setupSelectedPhotos(assets:[ImageAsset])
    func setupCurrentRemoteAsset(at index:Int)
    func performRemotePlay()
    func performRemoteStop()
}

protocol MediaSharePhotosInteractorOutput: class {
    func deviceNotConnect()
    func didConnected(_ device:DMR)
   
    func failureAuthorizedPermission()
    func successAuthorizedPermission()
    
    func didSetRemoteAssetSuccess()
    func didSetRemoteAssetFailure()
    
    func didPlayRemoteAssetSuccess()
    func didPlayRemoteAssetFailure()
    
    func didStopRemoteAssetFailure()
}

protocol MediaSharePhotosWireframe: class {
    func presentDMRList()
}
