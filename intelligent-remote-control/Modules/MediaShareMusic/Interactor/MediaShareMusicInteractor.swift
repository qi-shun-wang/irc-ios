//
//  MediaShareMusicInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import MediaPlayer

class MediaShareMusicInteractor {
    
    // MARK: Properties
    lazy var queryPlaylists:MPMediaQuery = MPMediaQuery.playlists()
    lazy var querySongs:MPMediaQuery = MPMediaQuery.songs()
    lazy var queryAlbums:MPMediaQuery = MPMediaQuery.albums()
    weak var output: MediaShareMusicInteractorOutput?
    
    let dlnaManager:DLNAMediaManagerProtocol
    
    init(dlnaManager:DLNAMediaManagerProtocol) {
        self.dlnaManager = dlnaManager
    }
}

extension MediaShareMusicInteractor: MediaShareMusicUseCase {
    
    func castSelectedSong(_ song: Song) {
        song.transform { (fileURL, error) in
            guard let url = fileURL else {print(error);return}
            self.dlnaManager.castSong(for: url)
        }
    }
    
    func fetchMusicAlbums() {
        let albums:[MPMediaItemCollection] = queryAlbums.collections ?? []
        output?.fetchedMusicAlbums(albums)
    }
    
    func fetchMusicSongs() {
        let songs:[MPMediaItem] = querySongs.items ?? []
        output?.fetchedMusicSongs(songs)
    }
    
    
    // TODO: Implement use case methods
    func fetchMusicPlaylists() {
        let playlists:[MPMediaItemCollection] = queryPlaylists.collections ?? []
        output?.fetchedMusicPlaylists(playlists)
    }
    
}

extension MPMediaItemCollection {
    
    func getPlaylistName() -> String {
        return self.value(forProperty: MPMediaPlaylistPropertyName) as? String ?? "No Name"
    }
    
    func getArtworkImage(size:CGSize) -> Image? {
        return self.representativeItem?.artwork?.image(at: size)
    }
    
    func getSongs()->[Song]{
        return self.items
    }
    
    func getAlbumArtistName() -> String {
        return self.representativeItem?.albumArtist  ?? "No Name"
    }
    
    func getAlbumName() -> String {
        return self.representativeItem?.albumName  ?? "No Name"
    }
    
}

extension MPMediaItem {
    
    func getSongName() -> String {
        return self.value(forProperty: MPMediaItemPropertyTitle) as? String ?? "No Name"
    }
    
    func getArtistName() -> String {
        return self.value(forProperty: MPMediaItemPropertyArtist) as? String ?? "No Name"
    }
    
    func getAlubmName() -> String {
        return self.value(forProperty: MPMediaItemPropertyAlbumTitle) as? String ?? "No Name"
    }
    
    func getArtworkImage(size:CGSize) -> Image? {
        return self.artwork?.image(at:size)
    }
    
}

extension MPMediaItem:Song {
    
    var name: String {
        get {
            return getSongName()}
    }
    
    var artistName: String {
        get {return getArtistName()}
    }
    
    var albumName: String {
        get {return getAlubmName()}
    }
    
    var artworkImage: Image? {
        get {return getArtworkImage(size:CGSize(width: 100, height: 100))}
    }
    
    var songURL: URL? {
        get {return assetURL}
    }
}

extension MPMediaItemCollection:Playlist,Album {
    
    var artistName: String {
        get {return getAlbumArtistName()}
    }
    
    var songs: [Song] {
        get {return getSongs()}
    }
    
    var artworkImage: Image? {
        get {return getArtworkImage(size:CGSize(width: 100, height: 100))}
    }
    
    var albumName: String {
        get {
            return getAlbumName()
        }
    }
    
    var playlistName: String {
        get {
            return getPlaylistName()
        }
    }
    
}

extension Song {
    func export(_ assetURL: URL,_ completion: @escaping DLNAMediaMusicAssetFileGeneratorCompletionHandler) {
        let asset = AVURLAsset(url: assetURL)
        guard let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality) else {
            completion(nil, ExportError.unableToCreateExporter)
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
    
    func transform(_ completion:@escaping DLNAMediaMusicAssetFileGeneratorCompletionHandler) {
        if let assetURL = self.songURL {
            export(assetURL,completion)
        }
    }
    typealias DLNAMediaMusicAssetFileGeneratorCompletionHandler = (_ fileURL:URL?, _ error: Error?) -> Void
    typealias DLNAMediaMusicAssetGeneratorCompletionHandler = (_ asset:MusicAsset?, _ error: Error?) -> Void
    
    func transformed(_ completion :@escaping DLNAMediaMusicAssetGeneratorCompletionHandler) {
        guard let url = songURL else {completion(nil, MusicConverterError.mediaItemAssetURLNotFound);return}
        let asset = AVURLAsset(url: url)
        
        let data:NSMutableData = NSMutableData()
        let reader:AVAssetReader
        do {
            reader = try AVAssetReader(asset: asset)
            
            let settings:[String : Any] = [
                AVFormatIDKey:kAudioFormatLinearPCM,
                AVSampleRateKey:44100,
                AVLinearPCMBitDepthKey:16,
                AVNumberOfChannelsKey:2,
                AVLinearPCMIsNonInterleaved:false,
                AVLinearPCMIsFloatKey:false,
                AVLinearPCMIsBigEndianKey:false
            ]
            
            let output = AVAssetReaderTrackOutput(track: asset.tracks[0], outputSettings: settings)
            reader.add(output)
            reader.startReading()
            while reader.status != .completed {
                guard let buffer = output.copyNextSampleBuffer() else {continue}
                guard let blockBuffer = CMSampleBufferGetDataBuffer(buffer) else {completion(nil,MusicConverterError.getDataBufferFromSampleBufferNull);return}
                let size = CMBlockBufferGetDataLength(blockBuffer)
                guard let outBytes = malloc(size) else {completion(nil,MusicConverterError.mallocNull);return}
                CMBlockBufferCopyDataBytes(blockBuffer, 0, size, outBytes)
                CMSampleBufferInvalidate(buffer)
                data.append(outBytes, length: size)
                free(outBytes)
                
            }
            completion(data,nil)
            
        }catch{
            completion(nil,MusicConverterError.useAVAssetReaderFailed)
        }
        
    }
    
    
}

enum MusicConverterError:Error {
    case mediaItemAssetURLNotFound
    case getDataBufferFromSampleBufferNull
    case mallocNull
    case useAVAssetReaderFailed
}

enum ExportError: Error {
    case unableToCreateExporter
}
