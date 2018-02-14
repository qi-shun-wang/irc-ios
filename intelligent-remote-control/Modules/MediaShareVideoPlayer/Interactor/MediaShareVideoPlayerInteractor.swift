//
//  MediaShareVideoPlayerInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/14.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import Photos
class MediaShareVideoPlayerInteractor {
    //    var fetchResult: PHFetchResult<PHAsset>? {didSet{loadAssetRandomly()}}
    
    // MARK: Properties
    let manager:DLNAMediaManager!
    weak var output: MediaShareVideoPlayerInteractorOutput?
    
    var video:PHAsset
    
    init(dlnaManager:DLNAMediaManagerProtocol,with video:VideoAsset) {
        self.manager = dlnaManager as! DLNAMediaManager
        //        loadLibrary()
        self.video = video as! PHAsset
        
    }
    
    
    //
    //    func loadLibrary() {
    //        PHPhotoLibrary.requestAuthorization { (status) in
    //            if status == .authorized {
    //                self.fetchResult = PHAsset.fetchAssets(with: .video, options: nil)
    //            }
    //        }
    //    }
    //
    func load(asset:PHAsset) {
//            guard let fetchResult = fetchResult, fetchResult.count > 0 else {
//                print("Error loading assets.")
//                return
//            }
//
//            let randomAssetIndex = Int(arc4random_uniform(UInt32(fetchResult.count - 1)))
//            let asset = fetchResult.object(at: randomAssetIndex)
            PHCachingImageManager().requestAVAsset(forVideo: asset, options: nil) { (avAsset, _, _) in
                DispatchQueue.main.async {
                    if let avAsset = avAsset {
                        self.output?.didLoad(avAsset)
                    }
                }
            }
        }
}

extension MediaShareVideoPlayerInteractor: MediaShareVideoPlayerUseCase {
    // TODO: Implement use case methods
    
    func fetchAsset(){
        load(asset: video)
    }
    
}
