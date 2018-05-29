//
//  DLNAMediaGenerator.swift
//  ExUPnP
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import Photos

class DLNAMediaGenerator:NSObject {
   
    let serverURL:String
    
    //initialize DLNAMediaGenerator when web server is started success.
    init(serverURL:String) {
        self.serverURL = serverURL
    }
    
    var imageList:[String:ImageAsset] = [:]
    var videoList:[String:VideoAsset] = [:]
    var musicList:[String:MusicAsset] = [:]
    
}

extension DLNAMediaGenerator: DLNAMediaLocalGeneratorProtocol {
    
    func clearAssets() {
        imageList = [:]
        videoList = [:]
        musicList = [:]
    }
    
    func generateImageURL(for asset: ImageAsset) -> String {
        let url = serverURL + "images/" + UUID().uuidString + ".png"
        imageList[url] = asset
        return url
    }
    
    func generateVideoURL(for asset: VideoAsset) -> String {
        let url = serverURL + "videos/" + UUID().uuidString + ".mp4"
        videoList[url] = asset
        return url
    }
    
    func generateMusicURL(for asset: MusicAsset,_ completion:@escaping DLNAMediaLocalGeneratorProtocol.MusicURLGeneratorCompletionHandler) {
        let url = serverURL + "music/" + UUID().uuidString + ".mp3"
        export(asset as! URL) { (fileURL, error) in
            guard let fileURL = fileURL else {return}
            self.musicList[url] = fileURL
            completion(url, nil)
        }
    }
    
   private func export(_ assetURL: URL,_ completion: @escaping DLNAMediaMusicAssetFileGeneratorCompletionHandler) {
        let asset = AVURLAsset(url: assetURL)
        guard let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {
            completion(nil, DLNAMediaGeneratorError.unableToCreateExporter)
            return
        }
        
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory())
            .appendingPathComponent(NSUUID().uuidString)
            .appendingPathExtension("mov")
        
        exporter.outputURL = fileURL
        exporter.outputFileType = AVFileType.mov
        
        exporter.exportAsynchronously {
            if exporter.status == .completed {
                completion(fileURL, nil)
            } else {
                completion(nil, exporter.error)
            }
        }
    }
    
    func generateImageData(with url: String, _ completion: @escaping DLNAMediaLocalGeneratorProtocol.ImageGeneratorCompletionHandler) {
        
        if let asset = imageList[url] as? PHAsset {
            let options = PHImageRequestOptions()
            options.isSynchronous = false
            options.deliveryMode = .highQualityFormat
            options.isNetworkAccessAllowed = true
            
            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: options, resultHandler: { (result, info) in
//                UIImageJPEGRepresentation(image, 1.0)
                if let image = result, let data = UIImagePNGRepresentation(image){
                    completion(data, nil)
                    
                } else {
                    completion(nil, DLNAMediaGeneratorError.imageGeneratorBroken)
                }
            })
        } else {
            completion(nil, DLNAMediaGeneratorError.wrongImagePHAssetType)
        }
        
    }
    
    func generateVideoFile(with url: String, _ completion: @escaping DLNAMediaLocalGeneratorProtocol.VideoGeneratorCompletionHandler) {
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
    
    func generateAudioFile(with url: String, _ completion: @escaping DLNAMediaLocalGeneratorProtocol.AudioGeneratorCompletionHandler) {
        if let audioFile = musicList[url] as? URL {
            completion(audioFile, nil)
        }else{
            completion(nil, DLNAMediaGeneratorError.wrongMusicAssetType)
        }
    }
    
}
