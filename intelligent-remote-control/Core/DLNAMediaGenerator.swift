//
//  DLNAMediaGenerator.swift
//  ExUPnP
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import Photos

protocol ImageAsset {}
protocol VideoAsset {}
protocol SlowMotion {}

extension PHAsset : ImageAsset, VideoAsset ,SlowMotion {}
extension AVURLAsset : VideoAsset {}
extension AVComposition : SlowMotion {}

enum DLNAMediaGeneratorError : Error {
    case imageGeneratorBroken
    case videoGeneratorBroken
    case slowMotionGeneratorBroken
    
    case wrongImagePHAssetType
    case wrongVideoPHAssetType
    case wrongSlowMotionPHAssetType
    
    case wrongVideoAVAssetType
    case wrongSlowMotionAVAssetType
}

protocol DLNAMediaLocalGeneratorProtocol {
    typealias DLNAMediaImageGeneratorCompletionHandler = (_ imageData:Data?, _ error: Error?) -> Void
    typealias DLNAMediaVideoGeneratorCompletionHandler = (_ fileURL:String?, _ error: Error?) -> Void
    typealias DLNAMediaSlowMotionGeneratorCompletionHandler = (_ fileURL:String?, _ error: Error?) -> Void
    
    func generateImageURL(for asset:ImageAsset)
    func generateVideoURL(for asset:VideoAsset)
    func generateSlowMotionURL(for asset:SlowMotion)
    
    func generateImageData(with url:String, _ completion: @escaping DLNAMediaImageGeneratorCompletionHandler)
    func generateVideoFile(with url:String, _ completion: @escaping DLNAMediaVideoGeneratorCompletionHandler)
    func generateSlowMotion(with url:String, _ completion: @escaping DLNAMediaVideoGeneratorCompletionHandler)
}


class DLNAMediaGenerator:NSObject{
    let serverURL:String
    
    //to do the initialized DLNAMediaGenerator when web server is started success.
    init(serverURL:String) {
        self.serverURL = serverURL
    }
    
    
    var imageList:[String:ImageAsset] = [:]
    var videoList:[String:VideoAsset] = [:]
    var slowMotionList:[String:SlowMotion] = [:]
}

extension DLNAMediaGenerator: DLNAMediaLocalGeneratorProtocol {
    
    func generateImageURL(for asset: ImageAsset) {
        let url = serverURL + "images/" + UUID().uuidString + ".jpeg"
        imageList[url] = asset
    }
    
    func generateVideoURL(for asset: VideoAsset) {
        let url = serverURL + "videos/" + UUID().uuidString + ".mp4"
        videoList[url] = asset
    }
    
    func generateSlowMotionURL(for asset: SlowMotion) {
        let url = serverURL + "slow_motions/" + UUID().uuidString + ".mp4"
        slowMotionList[url] = asset
        
    }
    
    func generateImageData(with url: String, _ completion: @escaping DLNAMediaLocalGeneratorProtocol.DLNAMediaImageGeneratorCompletionHandler) {
        
        if let asset = imageList[url] as? PHAsset {
            let options = PHImageRequestOptions()
            options.isSynchronous = false
            options.deliveryMode = .highQualityFormat
            options.isNetworkAccessAllowed = true
            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: options, resultHandler: { (result, info) in
                if let image = result, let data = UIImageJPEGRepresentation(image, 1.0) {
                    completion(data, nil)
                    
                } else {
                    completion(nil, DLNAMediaGeneratorError.imageGeneratorBroken)
                }
            })
        } else {
            completion(nil, DLNAMediaGeneratorError.wrongImagePHAssetType)
        }
        
    }
    
    func generateVideoFile(with url: String, _ completion: @escaping DLNAMediaLocalGeneratorProtocol.DLNAMediaVideoGeneratorCompletionHandler) {
        if let asset = videoList[url] as? PHAsset {
            
            let imageManager = PHImageManager.default()
            let videoRequestOptions = PHVideoRequestOptions()
            
            videoRequestOptions.deliveryMode = .automatic
            videoRequestOptions.version = .current
            videoRequestOptions.isNetworkAccessAllowed = true
            
            imageManager.requestAVAsset(forVideo: asset, options: videoRequestOptions, resultHandler: { (avAsset, avAudioMix, info) in
                
                if let nextURLAsset = avAsset as? AVURLAsset {
                    let filepath = nextURLAsset.url.path
                    completion(filepath, nil)
                }else {
                    completion(nil, DLNAMediaGeneratorError.wrongVideoAVAssetType)
                }
            })
        } else {
            completion(nil, DLNAMediaGeneratorError.wrongVideoPHAssetType)
        }
    }
    
    func generateSlowMotion(with url: String, _ completion: @escaping DLNAMediaLocalGeneratorProtocol.DLNAMediaVideoGeneratorCompletionHandler) {
        if let asset = slowMotionList[url] as? PHAsset {
            
            let imageManager = PHImageManager.default()
            let videoRequestOptions = PHVideoRequestOptions()
            
            videoRequestOptions.deliveryMode = .automatic
            videoRequestOptions.version = .current
            videoRequestOptions.isNetworkAccessAllowed = true
            imageManager.requestAVAsset(forVideo: asset, options: videoRequestOptions, resultHandler: { (avAsset, avAudioMix, info) in
                if let slowMotion = avAsset as? AVComposition {
                    let paths =  NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                    let doc = paths.first ?? ""
                    
                    let path = url.components(separatedBy: self.serverURL).last ?? ""
                    let videoPath:String = doc.appending("/\(path)")
                    let videoUrl:URL = URL(fileURLWithPath: videoPath)
                    
                    let export = AVAssetExportSession(asset: slowMotion, presetName: AVAssetExportPresetHighestQuality)
                    
                    export?.outputURL = videoUrl
                    export?.outputFileType = AVFileType.mp4
                    export?.shouldOptimizeForNetworkUse = true
                    
                    export?.exportAsynchronously(completionHandler: {
                        DispatchQueue.main.async {
                            if (export!.status == AVAssetExportSessionStatus.completed) {
                                let url:URL = export!.outputURL!
                                print("--->",url,slowMotion,export!.status)
                                completion(url.absoluteString,nil)
                                
                            }
                        }
                    })
                } else {
                    completion(nil,DLNAMediaGeneratorError.wrongSlowMotionAVAssetType)
                }
                
                
            })
        } else {
            completion(nil,DLNAMediaGeneratorError.wrongSlowMotionPHAssetType)
        }
    }
    
    
}
