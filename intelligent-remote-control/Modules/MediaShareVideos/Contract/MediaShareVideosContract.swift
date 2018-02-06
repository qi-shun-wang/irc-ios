//
//  MediaShareVideosContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/6.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol MediaShareVideosView: BaseView {
    func fetchedPhotoSize() -> Size?
    func reloadVideosCollectionView()
}

protocol MediaShareVideosPresentation: BasePresentation {
    func performVideoCast()
    func stopVideoCast()
    func didSelectItem(at indexPath: IndexPath)->(Bool)
    func numberOfItems(in section:Int) -> Int
    func itemInfo(at indexPath:IndexPath,_ isSelected:@escaping (Bool) -> Void, _ resultHandler: @escaping (Image?,[AnyHashable:Any]?)->Void)
    func setupAssetFetchOptions()
}

protocol MediaShareVideosUseCase: class {
    func checkConnectionStatus()
    func castSelectedVideo(_ asset:VideoAsset)
    func stopCasting()
}

protocol MediaShareVideosInteractorOutput: class {
    func deviceNotConnect()
    func didConnected(_ device:DMR)
    func didStartCasting()
    func willStartNext()
    func didStopedCasting()

}

protocol MediaShareVideosWireframe: class {
    func presentDMRList()
}
