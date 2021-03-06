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

enum DLNAMediaManagerError:Error {
    case notImplemented
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
            UPPEventSubscriptionManager.shared().subscribeObserver(self, to: transportService!)
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
                    completion(mediaNoteFoundResponse)
                }
                
            })
        })
        
        mediaServer?.addHandler(forMethod: "GET", path: "/index.html", request: GCDWebServerRequest.self, processBlock: { (req) -> GCDWebServerResponse? in
            let html = "<html><body><p>Hello</p></body></html>"
            return GCDWebServerDataResponse(html: html)
        })
        
        
        mediaServer?.addHandler(forMethod: "GET", pathRegex: "/music/", request: GCDWebServerRequest.self, asyncProcessBlock: { (request, completion) in
            let url = request.url.absoluteString
            self.mediaGenerator?.generateAudioFile(with: url, { (url, error) in
                if let file = url?.path {
                    let response = GCDWebServerFileResponse(file: file, byteRange: request.byteRange)
                    completion(response)
                } else {
                    completion(mediaNoteFoundResponse)
                }
            }) 
        })
        
        
        let options: Dictionary<String, Any> = [
            GCDWebServerOption_Port : port,
            GCDWebServerOption_AutomaticallySuspendInBackground: false
        ]
        mediaServer!.delegate = self
        do {
            try  mediaServer?.start(options: options)
        }catch{
            print("failed Running server :",error)
        }
    }
}

extension DLNAMediaManager:DLNAMediaManagerProtocol {
   
    func clearAssets() {
        mediaGenerator?.clearAssets()
    }
    
    func removeCurrentDevice() {
        currentDevice = nil
    }
    
    func getCurrentDevice() -> DMR? {
        return currentDevice
    }
    
    func setupCurrent(device: DMR) {
        currentDevice = device
    }
    
    func fetchMute(_ completion: @escaping DLNAMediaMuteStatusCompletionHandler) {
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
    
    func fetchVolume(_ completion: @escaping DLNAMediaVolumeStatusCompletionHandler) {
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
    
    func fetchCurrentTimeInterval(_ completion: @escaping DLNAMediaManagerProtocol.DLNAMediaTimeIntervalStatusCompletionHandler) {
        transportService?.positionInfo(withInstanceID: instanceID, completion: { (data, error) in
            guard let dictionary = data ,let timeInterval = dictionary["AbsTime"] as? String else {
                completion(0, error)
                return
            }
            let timeComponents = timeInterval.components(separatedBy: ":")
            if timeComponents.count != 3 {
                completion(0,DLNAMediaManagerError.notImplemented)
            } else {
                guard let hour = Double(timeComponents[0]),
                    let minute = Double(timeComponents[1]),
                    let second = Double(timeComponents[2])
                    else {return completion(0,DLNAMediaManagerError.notImplemented)}
                completion(hour*60 + minute*60 + second , nil)
            }

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
    
    func castImage(for asset: ImageAsset, _ completion: @escaping DLNAMediaMusicControlCompletionHandler) {
        guard let url = mediaGenerator?.generateImageURL(for: asset) else {
            print("Media Generator did not initialized")
            return
        }
//        transportService?.setAVTransportURI(url, currentURIMetaData: nil, instanceID: instanceID, success: { (isSuccess, error) in
//            guard error == nil else {print(error!); return}
//            if isSuccess {
//                self.transportService?.play(withInstanceID: self.instanceID, success: completion)
//            }
//        })
        transportService?.setAVTransportURI(url, currentURIMetaData: nil, instanceID: self.instanceID, success: completion)
    }
    
    func castVideo(for asset: VideoAsset, _ completion: @escaping DLNAMediaMusicControlCompletionHandler) {
        guard let url = mediaGenerator?.generateVideoURL(for: asset) else {
            print("Media Generator did not initialized")
            return
        }
        
        transportService?.setAVTransportURI(url, currentURIMetaData: nil, instanceID: instanceID, success:completion)
    }

    func castSong(for asset: MusicAsset, _ completion: @escaping DLNAMediaMusicControlCompletionHandler) {
        mediaGenerator?.generateMusicURL(for: asset, { (url, error) in
            guard let url = url else {
                completion(false, DLNAMediaGeneratorError.failureGeneratedMusicURL)
                print("Media Generator did not initialized")
                return
            }
          
            self.transportService?.setAVTransportURI(url, currentURIMetaData: nil, instanceID: self.instanceID, success: completion)
            
        })
    }
  
    func play(_ completion: @escaping DLNAMediaMusicControlCompletionHandler){
        transportService?.play(withInstanceID: instanceID, success: completion)
    }
    
    func pause(_ completion: @escaping DLNAMediaMusicControlCompletionHandler){
        transportService?.pause(withInstanceID: instanceID, success: completion)
    }
    
    func previousSong(_ completion: @escaping DLNAMediaManagerProtocol.DLNAMediaMusicControlCompletionHandler) {
        transportService?.previous(withInstanceID: instanceID, success: completion)
    }
    
    func nextSong(_ completion: @escaping DLNAMediaManagerProtocol.DLNAMediaMusicControlCompletionHandler) {
        transportService?.next(withInstanceID: instanceID, success: completion)
    }
    
    func stop(_ completion: @escaping DLNAMediaMusicControlCompletionHandler){
        transportService?.stop(withInstanceID: instanceID, success: completion)
    }
    
    func seek(at position: String, _ completion: @escaping DLNAMediaMusicControlCompletionHandler) {
        let p = UPPParameters.params(withKeys: ["InstanceID","Unit","Target"],
                                     values: ["0","REL_TIME",position])
        transportService?._sendPostRequest(with: p, action:  "Seek", success: completion)
    }
    
    func setPlayMode(mode: String, _ completion: @escaping DLNAMediaMusicControlCompletionHandler) {
        transportService?.setPlayMode(mode, withInstanceID: instanceID, success: completion)
    }
    
}

extension DLNAMediaManager:UPPDiscoveryDelegate {
    
    func discovery(_ discovery: UPPDiscovery, didFind device: UPPBasicDevice) {
        if devices.contains(device) {
            return
        }
        devices.append(device)
//        let row = devices.index(of: device)!
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

extension DLNAMediaManager:UPPEventSubscriptionDelegate{
    func eventRecieved(_ event: [AnyHashable : Any]) {
        
        guard let event = (event["Event"] as? Dictionary<AnyHashable,Any>) else {return}
        delegate?.didEventRecieved(event)
    }
}

