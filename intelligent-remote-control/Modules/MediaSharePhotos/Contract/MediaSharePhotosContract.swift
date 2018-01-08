//
//  MediaSharePhotosContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol MediaSharePhotosView: BaseView {
    // TODO: Declare view methods
    
    //segment control
    func setupSegment()
    //collection view
    func setupPhotosCollectionView(tag: Int)
    func setupVideosCollectionView(tag: Int)
    func showPhotosCollectionView()
    func showVideosCollectionView()
    func setupToolBarLeftItem(image named: String, title text: String)
    func fetchedPhotoSize() -> Size?
    func reloadPhotosCollectionView()
    func reloadVideosCollectionView()
}

protocol MediaSharePhotosPresentation: BasePresentation {
    // TODO: Declare presentation methods
    func switchOnSegment(at index:Int)
    func showDMRList()
    func didSelectItem(about tag:Int, at indexPath: IndexPath)
    func numberOfItems(about tag:Int, in section:Int) -> Int
    func itemInfo(about tag:Int ,at indexPath:IndexPath, _ resultHandler: @escaping (Image?,[AnyHashable:Any]?)->Void)
    func setupAssetFetchOptions()
}

protocol MediaSharePhotosUseCase: class {
    // TODO: Declare use case methods
    func castSelectedImage(_ asset:ImageAsset)
    func castSelectedVideo(_ asset:VideoAsset)
}

protocol MediaSharePhotosInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol MediaSharePhotosWireframe: class {
    // TODO: Declare wireframe methods
    func presentDMRList()
}

protocol Image {}

protocol Size {
    var w:Float{get set}
    var h:Float{get set}
}
