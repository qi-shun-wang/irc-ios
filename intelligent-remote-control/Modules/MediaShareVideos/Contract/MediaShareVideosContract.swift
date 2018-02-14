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
    func stopVideoCast()
    func didSelectItem(at indexPath: IndexPath)
    func numberOfItems(in section:Int) -> Int
    func itemInfo(at indexPath:IndexPath, _ resultHandler: @escaping (Image?,[AnyHashable:Any]?)->Void)
    func setupAssetFetchOptions()
}

protocol MediaShareVideosUseCase: class {
    func stopCasting()
}

protocol MediaShareVideosInteractorOutput: class {
    func didStopedCasting()
}

protocol MediaShareVideosWireframe: class {
    func pushVideoPlayer(_ video:VideoAsset)
}
