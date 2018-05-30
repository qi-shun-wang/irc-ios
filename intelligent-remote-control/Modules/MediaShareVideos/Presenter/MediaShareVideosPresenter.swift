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
    @objc fileprivate func checkVideos(){
        interactor?.checkPhotoPermission()
    }
}

extension MediaShareVideosPresenter: MediaShareVideosPresentation {
    
    func viewWillAppear() {
        NotificationCenter.default.addObserver(self, selector: #selector(checkVideos), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    func viewWillDisappear() {
        NotificationCenter.default.removeObserver(self)
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
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupWarningBadge()
        photoSize = view?.fetchedPhotoSize()
        interactor?.checkPhotoPermission()
        
        
    }
}

extension MediaShareVideosPresenter: MediaShareVideosInteractorOutput {
    
    func failureAuthorizedPermission() {
        DispatchQueue.main.async {
            self.view?.showTips()
        }
    }
    
    func successAuthorizedPermission() {
        videos = PHAsset.fetchAssets(with: .video, options: nil)
        DispatchQueue.main.async {
            self.view?.hideTips()
        }
    }
    
    
    func didStopedCasting() {
    }
}
