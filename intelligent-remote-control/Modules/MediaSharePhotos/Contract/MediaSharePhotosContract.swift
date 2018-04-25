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
    func stopImageCast()
    func didSelectItem(at indexPath: IndexPath)->(Bool)
    func numberOfItems(in section:Int) -> Int
    func itemInfo(at indexPath:IndexPath,_ isSelected:@escaping (Bool) -> Void, _ resultHandler: @escaping (Image?,[AnyHashable:Any]?)->Void)
    func checkingConnectedDevice()
    func performImageCast()
}

protocol MediaSharePhotosUseCase: class {
    func checkPhotoPermission()
    func checkConnectionStatus()
    func castSelectedImage(_ asset:ImageAsset)
    func stopCasting()
}

protocol MediaSharePhotosInteractorOutput: class {
    func deviceNotConnect()
    func didConnected(_ device:DMR)
    func didStartCasting()
    func willStartNext()
    func didStopedCasting()
    func failureAuthorizedPermission()
    func successAuthorizedPermission()
}

protocol MediaSharePhotosWireframe: class {
    func presentDMRList()
}
