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
    var photosAsset: PHFetchResult<PHAsset>!
    var videosAsset: PHFetchResult<PHAsset>!
    var photoSize:Size?
    var selectedPhotoIndexes = [IndexPath]()
    var currentCastIndex:Int = 0
    
    var currentMediaType:PhotosCollectionType = .photo
    
    lazy var worker:Worker = Worker(repeatedAction: repeatedAction)
    
    lazy var repeatedAction:(()->Void) = {
        let selectedPhotos = self.selectedPhotoIndexes
        let i = self.currentCastIndex
        let max = selectedPhotos.count
        let assets = self.photosAsset!
        guard max != 0 else {self.interactor?.stopCasting();return}
        guard i < max else {self.currentCastIndex = 0 ;return}
        self.interactor?.castSelectedImage(assets[selectedPhotos[i].item])
        self.currentCastIndex += 1
    }
    
    private func improved(isPlaying:Bool){
        guard selectedPhotoIndexes.count > 0 else {
            view?.showWarningBadge(with: "請選擇至少一張相片來投放")
            return
        }
        view?.hideWarningBadge(with: "即將為你投放...")
        worker.isPlaying = isPlaying
        check()
    }
    
    private func check(){
        if worker.isPlaying {
            view?.setupMediaControlToolBar(text: "暫停投放圖片")
        }else {
            view?.setupMediaControlToolBar(text: "開始投放圖片")
        }
    }
}

extension MediaSharePhotosPresenter: MediaSharePhotosPresentation {
    
    // TODO: implement presentation methods
    func itemInfo(about tag: Int, at indexPath: IndexPath, _ isSelected: @escaping (Bool) -> Void, _ resultHandler: @escaping (Image?, [AnyHashable : Any]?) -> Void) {
        let asset: PHAsset
        guard let type = PhotosCollectionType(rawValue: tag) else {return}
        switch type {
        case .video:
            asset = videosAsset[indexPath.item]
        case .photo:
            asset = photosAsset[indexPath.item]
            let isPhotoSelected = (selectedPhotoIndexes.index(of: indexPath) != nil)
            isSelected(isPhotoSelected)
        }
        PHImageManager.default().requestImage(for: asset, targetSize: photoSize as! CGSize, contentMode: .aspectFill, options: nil, resultHandler: resultHandler)
        
    }
   
    func numberOfItems(about tag: Int, in section: Int) -> Int {
        guard let type = PhotosCollectionType(rawValue: tag) else {return 0}
        switch type {
        case .video: return videosAsset.count
        case .photo: return photosAsset.count
        }
    }
    
    func showDMRList() {
        router?.presentDMRList()
    }
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupSegment()
        view?.setupPhotosCollectionView(tag: PhotosCollectionType.photo.rawValue)
        view?.setupVideosCollectionView(tag: PhotosCollectionType.video.rawValue)
        view?.setupToolBarLeftItem(image: "media_share_cast_icon", title: "尚未連接設備")
        view?.setupMediaControlToolBar(text: "開始投放圖片")
        view?.showPhotosCollectionView()
        view?.setupWarningBadge()
        photoSize = view?.fetchedPhotoSize()
        
    }
    
    func setupAssetFetchOptions(){
        let fetchOptions = PHFetchOptions()
        fetchOptions.includeAssetSourceTypes = .typeUserLibrary
        photosAsset = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        fetchOptions.predicate = NSPredicate(format: "NOT ((mediaSubtype & %d) != 0)", PHAssetMediaSubtype.videoHighFrameRate.rawValue)
        videosAsset = PHAsset.fetchAssets(with: .video, options: fetchOptions)
    }
    
    func switchOnSegment(at index: Int) {
        guard let type = PhotosCollectionType(rawValue: index) else {return}
        currentMediaType = type
        switch currentMediaType {
        case .photo:
            view?.showPhotosCollectionView()
            check()
        case .video:
            view?.showVideosCollectionView()
            view?.setupMediaControlToolBar(text: "開始投放影片")
        }
    }
    
    func didSelectItem(about tag: Int, at indexPath: IndexPath) -> Bool {
        
        guard let type = PhotosCollectionType(rawValue: tag) else {return false }
        switch type {
        case .video: interactor?.castSelectedVideo(videosAsset[indexPath.row]) ;return false
        case .photo:
            if let index = selectedPhotoIndexes.index(of: indexPath) {
                selectedPhotoIndexes.remove(at: index)
                return false
            } else {
                selectedPhotoIndexes.append(indexPath)
                return true
            }
        }
        
    }
    
    func performMediaCast() {
        switch currentMediaType {
        case .photo:
            worker.isPlaying ? improved(isPlaying: false) : improved(isPlaying: true)
        case .video:
            break
        }
    }
}

extension MediaSharePhotosPresenter: MediaSharePhotosInteractorOutput {
    // TODO: implement interactor output methods
    func stopedCasting() {
        worker.isPlaying = false
        view?.setupMediaControlToolBar(text: "開始投放圖片")
    }
}
