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
    //test
    var assetCollection: PHAssetCollection!
    var photosAsset: PHFetchResult<PHAsset>!
    var photoSize:Size?
    
   
}

extension MediaSharePhotosPresenter: MediaSharePhotosPresentation {
    
    // TODO: implement presentation methods
    func itemInfo(at indexPath: IndexPath, _ resultHandler: @escaping (Image?, [AnyHashable : Any]?) -> Void) {
        let asset: PHAsset = photosAsset[indexPath.item]
        PHImageManager.default().requestImage(for: asset, targetSize: photoSize as! CGSize, contentMode: .aspectFill, options: nil, resultHandler: resultHandler)
        
    }
    
    func numberOfItems(in section: Int) -> Int {
         return photosAsset.count
    }
    
    func showDMRList() {
        router?.presentDMRList()
    }
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupSegment()
        view?.setupPhotosCollectionView(tag: PhotosCollectionType.photo.rawValue)
        view?.setupVideosCollectionView(tag: PhotosCollectionType.video.rawValue)
        view?.setupNavigationToolBarLeftItem(image: "media_share_cast_icon", title: "")
        photoSize = view?.fetchedPhotoSize()
        
    }
    
    func setupAssetFetchOptions(){
        let fetchOptions = PHFetchOptions()
        fetchOptions.includeAssetSourceTypes = .typeUserLibrary
        photosAsset = PHAsset.fetchAssets(with: .image, options: fetchOptions)
    }
    
    func switchOnSegment(at index: Int) {
        guard let type = PhotosCollectionType(rawValue: index) else {return}
        switch type {
        case .photo: view?.showPhotosCollectionView()
        case .video: view?.showVideosCollectionView()
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        interactor?.castSelectedImage(photosAsset[indexPath.row])
    }
}

extension MediaSharePhotosPresenter: MediaSharePhotosInteractorOutput {
    // TODO: implement interactor output methods
}
