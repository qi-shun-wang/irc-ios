//
//  DLNAMediaManager.swift
//  ExUPnP
//
//  Created by QiShunWang on 2018/1/2.
//  Copyright © 2018年 ising99. All rights reserved.
//

import CocoaUPnP
import Photos
import MediaPlayer
import AVFoundation
import AssetsLibrary

protocol DMR {
    var name:String {get}
}
extension UPPBasicDevice:DMR {
    var name: String {
        get{
            return self.friendlyName
        }
        
    }
}
protocol DLNAMediaManagerProtocol: class {
    typealias DLNAMediaMuteStatusCompletionHandler = (_ isMute:Bool, _ error: Error?) -> Void
    typealias DLNAMediaVolumeStatusCompletionHandler = (_ volume:Int, _ error: Error?) -> Void
    func startServer()
    func stopServer()
    func startDiscover()
    func stopDiscover()
    func change(mute isMute:Bool)
    func change(volume value:Int)
    func fetchMute(_ completion: @escaping DLNAMediaMuteStatusCompletionHandler)
    func fetchVolume(_ completion: @escaping DLNAMediaVolumeStatusCompletionHandler)
    func getCurrentDevice() -> DMR?
    func setupCurrent(device:DMR)
    func setupCurrentTransport(photos urls:[String])
    func setupCurrentTransport(videos urls:[String])
    func play()
    func stop()
    func next()
    func previous()
    
    func castImage(for asset:ImageAsset)
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
    
}

class DLNAMediaManager:NSObject {
    
    private let renderServiceType = "RenderingControl"
    private let transportServiceType = "AVTransport"
    private let instanceID = "0"
    private let channel = "Master"
    
    private var mediaServer:GCDWebServer?
    private var serverURL: String {
        get {
            return mediaServer?.serverURL?.absoluteString ?? ""
        }
    }
    
    fileprivate var mediaGenerator:DLNAMediaLocalGeneratorProtocol?
    
    var delegate:DLNAMediaManagerDelegate?
    
    fileprivate var devices:[UPPBasicDevice] = []
    
    var currentDevice:DMR? {
        didSet{
            guard let render = currentDevice as? UPPMediaRendererDevice else { return }
            guard let renderDescription = render.service(forType: renderServiceType) else {return }
            
            renderService = UPPRenderingControlService(baseURL: render.baseURL, description: renderDescription, uniqueDeviceName: render.udn)
            
            guard let transportDescription = render.service(forType: transportServiceType) else {return}
            transportService = UPPAVTransportService(baseURL: render.baseURL, description: transportDescription, uniqueDeviceName: render.udn)
            
        }
    }
    
    fileprivate var transportService:UPPAVTransportService?{
        didSet{
            delegate?.didSetupTransportService()
        }
    }
    
    
    fileprivate var renderService:UPPRenderingControlService?{
        didSet{
            delegate?.didSetupRenderService()
        }
    }
    
    
    
    private func setupServer(_ server:GCDWebServer,on port: UInt = 8800) {
        
        mediaServer = server
        let mediaNoteFoundResponse = GCDWebServerResponse(statusCode: 404)
        
        mediaServer?.addHandler(forMethod: "GET", pathRegex: "/videos/", request: GCDWebServerRequest.self, asyncProcessBlock: { (request, completion) in
            let url = request.url.absoluteString
            self.mediaGenerator?.generateVideoFile(with: url, { (file, error) in
                if let file = file {
                    let response = GCDWebServerFileResponse(file: file, byteRange: request.byteRange)
                    completion(response)
                } else {
                    print(error!)
                    completion(mediaNoteFoundResponse)
                }
            })
            
            
        })
        
        mediaServer?.addHandler(forMethod: "GET", pathRegex: "/images/", request: GCDWebServerRequest.self, asyncProcessBlock: { (request, completion) in
            let url = request.url.absoluteString
            self.mediaGenerator?.generateImageData(with: url, { (data, error) in
                if let data = data {
                    let response = GCDWebServerDataResponse(data: data, contentType: "image/jpeg")
                    completion(response)
                } else {
                    print(error!)
                    completion(mediaNoteFoundResponse)
                }
                
            })
        })
        
        mediaServer?.addHandler(forMethod: "GET", path: "/index.html", request: GCDWebServerRequest.self, processBlock: { (req) -> GCDWebServerResponse? in
            let html = "<html><body><p>Hello</p></body></html>"
            return GCDWebServerDataResponse(html: html)
        })
        //        mediaServer?.addHandler(forMethod: "GET", pathRegex: "/music", request: GCDWebServerRequest.self, asyncProcessBlock: { (req, compl) in
        //            let path = "\(req.path)".trimmingCharacters(in: CharacterSet(charactersIn: "music/"))
        //            print(path)
        //
        //
        //            if let url = self.musicPath {
        //                let asset = AVURLAsset(url: url, options: nil)
        //
        //                let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A)
        //                exporter?.outputFileType = AVFileType.m4a
        //                //                compl( GCDWebServerDataResponse(data: data, contentType: "image/jpeg"))
        //            }
        //
        //        })
        
        
        let options: Dictionary<String, Any> = ["Port" : port,GCDWebServerOption_AutomaticallySuspendInBackground: false]
        mediaServer!.delegate = self
        do {
            try  mediaServer?.start(options: options)
        }catch{
            print("failed Running server :",error)
        }
    }
}

extension DLNAMediaManager:DLNAMediaManagerProtocol {
    
    func getCurrentDevice() -> DMR? {
        return currentDevice
    }
    
    func play() {
        transportService?.play(withInstanceID: instanceID , success: { (isSuccess, error) in
            print(isSuccess, error)
        })
        //        transportService?.play(withInstanceID: instanceID )
    }
    
    func stop() {
        
    }
    
    func next() {
        
    }
    
    func previous() {
        
    }
    
    func setupCurrentTransport(photos urls: [String]) {
        urls.forEach { (url) in
            transportService?.setNextAVTransportURI(url, nextURIMetaData: nil, instanceID: instanceID, success: { (isOk, error) in
                print(isOk, error)
            })
            //            transportService?.setNextAVTransportURI(url, nextURIMetaData: nil, instanceID: instanceID)
        }
    }
    
    func setupCurrentTransport(videos urls: [String]) {
        
    }
    
    func setupCurrent(device: DMR) {
        currentDevice = device
    }
    
    func fetchMute(_ completion: @escaping DLNAMediaManagerProtocol.DLNAMediaMuteStatusCompletionHandler) {
        renderService?.mute(withInstanceID: instanceID, channel: channel, completion: { (data, error) in
            guard let anyMute = data?["CurrentMute"] else{
                completion(true, error)
                return
            }
            let stringMute = "\(anyMute)"
            let isMute = stringMute == "0" ? false : true
            completion(isMute, nil)
        })
    }
    
    func fetchVolume(_ completion: @escaping DLNAMediaManagerProtocol.DLNAMediaVolumeStatusCompletionHandler) {
        renderService?.volume(withInstanceID: instanceID, channel: channel, completion: { (data, error) in
            guard let dictionary = data ,let anyVolume = dictionary["CurrentVolume"] else {
                completion(0, error)
                return
            }
            
            let stringVolume = "\(anyVolume)"
            let volume = Int(stringVolume) ?? 0
            completion(volume, nil)
            
        })
    }
    
    func change(mute isMute: Bool) {
        renderService?.setMute(isMute, withInstanceID: instanceID, channel: channel, success: { (isSuccess, error) in
            if isSuccess {
                self.delegate?.didChangeMute()
            }else {
                self.delegate?.didFailureChangeMute()
            }
        })
    }
    
    func change(volume value: Int) {
        let volume = NSNumber(value:value)
        renderService?.setVolume(volume ,withInstanceID: instanceID, channel: channel, success: { (isSuccess, error) in
            if isSuccess {
                self.delegate?.didChangeVolume()
            }else {
                self.delegate?.didFailureChangeVolume()
            }
        })
    }
    
    func startServer() {
        let server = GCDWebServer()
        setupServer(server)
    }
    
    func stopServer() {
        mediaServer?.stop()
    }
    
    func startDiscover() {
        UPPDiscovery.sharedInstance().addBrowserObserver(self)
        UPPDiscovery.sharedInstance().startBrowsing(forServices: "ssdp:all")
    }
    
    func stopDiscover() {
        UPPDiscovery.sharedInstance().forgetAllKnownDevices()
        UPPDiscovery.sharedInstance().stopBrowsingForServices()
        UPPDiscovery.sharedInstance().removeBrowserObserver(self)
    }
    func castImage(for asset: ImageAsset) {
        guard let url = mediaGenerator?.generateImageURL(for: asset) else {
            print("Media Generator did not initialized")
            return
        }
        
        transportService?.setAVTransportURI(url, currentURIMetaData: nil, instanceID: instanceID, success: { (isSuccess, error) in
            guard error == nil else {print(error!); return}
            if isSuccess {
                self.transportService?.play(withInstanceID: self.instanceID, success: { (isSucces, error) in
                    print(error)
                })
            }
        })
        
    }
}

extension DLNAMediaManager:UPPDiscoveryDelegate {
    
    func discovery(_ discovery: UPPDiscovery, didFind device: UPPBasicDevice) {
        if devices.contains(device) {
            return
        }
        devices.append(device)
        let row = devices.index(of: device)!
        delegate?.didFind(device: device)
    }
    
    func discovery(_ discovery: UPPDiscovery, didRemove device: UPPBasicDevice) {
        if !devices.contains(device) {
            return
        }
        let row = devices.index(of: device)!
        devices.remove(at: row)
        delegate?.didRemove(at:row)
        
    }
    
}
extension DLNAMediaManager:GCDWebServerDelegate {
    
    func webServerDidStart(_ server: GCDWebServer) {
        print("--->Start:",server.serverURL!.absoluteString)
        mediaGenerator = DLNAMediaGenerator(serverURL: server.serverURL!.absoluteString)
    }
    
    func webServerDidStop(_ server: GCDWebServer) {
        print("--->Stop:",server.debugDescription)
    }
    
}
//extension PHAsset {
//
//    func getURL(completionHandler : @escaping ((_ responseURL : URL?) -> Void)){
//        if self.mediaType == .image {
//            let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
//            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
//                return true
//            }
//            self.requestContentEditingInput(with: options, completionHandler: {(contentEditingInput: PHContentEditingInput?, info: [AnyHashable : Any]) -> Void in
//                completionHandler(contentEditingInput!.fullSizeImageURL as URL?)
//            })
//        } else if self.mediaType == .video {
//            let options: PHVideoRequestOptions = PHVideoRequestOptions()
//            options.version = .original
//            PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable : Any]?) -> Void in
//                if let urlAsset = asset as? AVURLAsset {
//                    let localVideoUrl: URL = urlAsset.url as URL
//                    completionHandler(localVideoUrl)
//                } else {
//                    completionHandler(nil)
//                }
//            })
//        }
//    }
//}
