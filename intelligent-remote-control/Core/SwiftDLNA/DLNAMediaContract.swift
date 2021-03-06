//
//  DLNAMediaContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/10.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol ImageAsset {}
protocol VideoAsset {}
protocol SlowMotion {}
protocol MusicAsset {}

protocol DMR {
    var name:String {get}
    var ip:String {get}
    var isConnected:Bool {get}
}


//DLNAMediaManager
protocol DLNAMediaManagerProtocol: class {
    typealias DLNAMediaMuteStatusCompletionHandler = (_ isMute:Bool, _ error: Error?) -> Void
    typealias DLNAMediaVolumeStatusCompletionHandler = (_ volume:Int, _ error: Error?) -> Void
    typealias DLNAMediaTimeIntervalStatusCompletionHandler = (_ seconds:Double, _ error: Error?) -> Void
    typealias DLNAMediaMusicControlCompletionHandler = (_ isSuccess:Bool, _ error: Error?) -> Void
    
    var delegate:DLNAMediaManagerDelegate?{get set}
    
    var currentDevice:DMR?{get set}
    func startServer()
    func stopServer()
    func startDiscover()
    func stopDiscover()
    func change(mute isMute:Bool)
    func change(volume value:Int)
    func fetchMute(_ completion: @escaping DLNAMediaMuteStatusCompletionHandler)
    func fetchVolume(_ completion: @escaping DLNAMediaVolumeStatusCompletionHandler)
    func fetchCurrentTimeInterval(_ completion: @escaping DLNAMediaTimeIntervalStatusCompletionHandler)
    func getCurrentDevice() -> DMR?
    func setupCurrent(device:DMR)
    func removeCurrentDevice()
    func play(_ completion: @escaping DLNAMediaMusicControlCompletionHandler)
    func pause(_ completion: @escaping DLNAMediaMusicControlCompletionHandler)
    func stop(_ completion: @escaping DLNAMediaMusicControlCompletionHandler)
    func previousSong(_ completion: @escaping DLNAMediaMusicControlCompletionHandler)
    func nextSong(_ completion: @escaping DLNAMediaMusicControlCompletionHandler)
    func setPlayMode(mode:String, _ completion: @escaping DLNAMediaMusicControlCompletionHandler)
    func seek(at position:String , _ completion: @escaping DLNAMediaMusicControlCompletionHandler)
    func castImage(for asset:ImageAsset, _ completion: @escaping DLNAMediaMusicControlCompletionHandler)
    func castVideo(for asset:VideoAsset, _ completion: @escaping DLNAMediaMusicControlCompletionHandler)
    func castSong(for asset:MusicAsset,_ completion: @escaping DLNAMediaMusicControlCompletionHandler)
    func clearAssets()
}
protocol DLNAMediaManagerDelegate {
    func didFailureChangeVolume()
    func didFailureChangeMute()
    
    func didFind(device:DMR)
    func didRemove(at index:Int)
    
    func didChangeMute()
    func didChangeVolume()
    func didSetupTransportService()
    func didSetupRenderService()
    
    func didEventRecieved(_ event:Dictionary<AnyHashable,Any>)
}




//DLNAMediaLocalGenerator
protocol DLNAMediaLocalGeneratorProtocol {
    typealias ImageGeneratorCompletionHandler = (_ imageData:Data?, _ error: Error?) -> Void
    typealias VideoGeneratorCompletionHandler = (_ fileURL:String?, _ error: Error?) -> Void
    typealias AudioGeneratorCompletionHandler = (_ fileURL:URL?, _ error: Error?) -> Void
    typealias MusicURLGeneratorCompletionHandler = (_ url:String?, _ error: Error?) -> Void
    
    typealias DLNAMediaMusicAssetFileGeneratorCompletionHandler = (_ fileURL:URL?, _ error: Error?) -> Void
    
    func generateImageURL(for asset:ImageAsset) -> String
    func generateVideoURL(for asset:VideoAsset) -> String
    func generateMusicURL(for asset:MusicAsset,_ completion:@escaping DLNAMediaLocalGeneratorProtocol.MusicURLGeneratorCompletionHandler)
    func clearAssets()
    
    func generateImageData(with url:String, _ completion: @escaping ImageGeneratorCompletionHandler)
    func generateVideoFile(with url:String, _ completion: @escaping VideoGeneratorCompletionHandler)
    func generateAudioFile(with url:String, _ completion: @escaping AudioGeneratorCompletionHandler)
}


