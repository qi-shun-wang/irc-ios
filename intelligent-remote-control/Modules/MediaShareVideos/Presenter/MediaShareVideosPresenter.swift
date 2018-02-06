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
    
    var videosAsset: PHFetchResult<PHAsset>!
    var photoSize:Size?
    
    var selectedVideoIndexes = [IndexPath]()
    var nextIndex:Int = 0
    let worker:Worker = Worker()
    var isStop:Bool = false
    var hasNext:Bool {
        get {
            return selectedVideoIndexes.count > 1 && nextIndex < selectedVideoIndexes.count - 1 && !isStop
        }
    }
    
    fileprivate func performCast(){
        
//        self.interactor?.castSelectedVideo(videosAsset[selectedVideoIndexes[]])
        
    }
}

extension MediaShareVideosPresenter: MediaShareVideosPresentation {
    func performVideoCast() {
        performCast()
        
    }
    
    func stopVideoCast() {
        interactor?.stopCasting()
    }
    
    func didSelectItem(at indexPath: IndexPath) -> (Bool) {
        if let index = selectedVideoIndexes.index(of: indexPath) {
            selectedVideoIndexes.remove(at: index)
            return false
        } else {
            selectedVideoIndexes.append(indexPath)
            return true
        }
    }
    
    func numberOfItems(in section: Int) -> Int {
        return videosAsset.count
    }
    
    func itemInfo(at indexPath: IndexPath, _ isSelected: @escaping (Bool) -> Void, _ resultHandler: @escaping (Image?, [AnyHashable : Any]?) -> Void) {
        let asset: PHAsset = videosAsset[indexPath.item]
        PHImageManager.default().requestImage(for: asset, targetSize: photoSize as! CGSize, contentMode: .aspectFill, options: nil, resultHandler: resultHandler)
    }
    
    func setupAssetFetchOptions() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.includeAssetSourceTypes = .typeUserLibrary
        fetchOptions.predicate = NSPredicate(format: "NOT ((mediaSubtype & %d) != 0)", PHAssetMediaSubtype.videoHighFrameRate.rawValue)
        videosAsset = PHAsset.fetchAssets(with: .video, options: fetchOptions)
    }
    
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupWarningBadge()
        photoSize = view?.fetchedPhotoSize()
    }
}

extension MediaShareVideosPresenter: MediaShareVideosInteractorOutput {
    func deviceNotConnect() {
        router?.presentDMRList()
        isStop = true
    }
    
    func didConnected(_ device: DMR) {
        
    }
    
    func didStartCasting() {
        
    }
    
    func willStartNext() {
        if hasNext {
            performCast()
            nextIndex += 1
        }
    }
    
    func didStopedCasting() {
        isStop = true
    }
    
    
}
