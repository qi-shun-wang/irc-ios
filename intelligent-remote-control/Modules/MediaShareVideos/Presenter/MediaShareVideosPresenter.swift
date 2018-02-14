//
//  MediaShareVideosPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/6.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import Photos

class MediaShareVideosPresenter {
    
    // MARK: Properties
    
    weak var view: MediaShareVideosView?
    var router: MediaShareVideosWireframe?
    var interactor: MediaShareVideosUseCase?
    
    var videos: PHFetchResult<PHAsset> = PHFetchResult<PHAsset>() {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadVideosCollectionView()
            }
            
        }
    }
    var photoSize:Size?
    
}

extension MediaShareVideosPresenter: MediaShareVideosPresentation {
    
    func stopVideoCast() {
        interactor?.stopCasting()
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let videoAsset = videos.object(at: indexPath.item)
        router?.pushVideoPlayer(videoAsset)
        
    }
    
    func numberOfItems(in section: Int) -> Int {
        return videos.count
    }
    
    func itemInfo(at indexPath: IndexPath, _ resultHandler: @escaping (Image?, [AnyHashable : Any]?) -> Void) {
        let asset: PHAsset = videos[indexPath.item]
        PHImageManager.default().requestImage(for: asset, targetSize: photoSize as! CGSize, contentMode: .aspectFill, options: nil, resultHandler: resultHandler)
    }
    
    func setupAssetFetchOptions() {
        
        PHPhotoLibrary.requestAuthorization { (status) in
            if status == .authorized {
                self.videos = PHAsset.fetchAssets(with: .video, options: nil)//fetchOptions)
            }
        }
        
    }
    
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupWarningBadge()
        photoSize = view?.fetchedPhotoSize()
    }
}

extension MediaShareVideosPresenter: MediaShareVideosInteractorOutput {
    
    func didStopedCasting() {
    }
}
