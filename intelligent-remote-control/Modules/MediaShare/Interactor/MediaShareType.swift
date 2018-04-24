//
//  MediaShareType.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

enum MediaShareType:MediaShareTypeProtocol {
    
    func getTitle() -> String {
        switch self {
        case .localPhotos:return "圖片"
        case .localVideos:return "影片"
        case .localMusic:return "音樂"
        case .remoteGoogle:return "Google Drive"
        case .remoteFacebook:return "Facebook"
        case .remoteInstagram:return "Instagram"
        case .remoteDropbox:return "Dropbox"
        }
    }
    
    func getImageName() -> String {
        switch self {
        case .localPhotos:return "media_share_photo_icon"
        case .localVideos:return "media_share_video_icon"
        case .localMusic:return "media_share_music_icon"
        case .remoteGoogle:return "meadia_share_google_drive_icon"
        case .remoteFacebook:return "media_share_facebook_icon"
        case .remoteInstagram:return "media_share_instagram_icon"
        case .remoteDropbox:return "meadia_share_dropbox_icon"
            
        }
    }
    
    case localPhotos
    case localMusic
    case localVideos
    case remoteGoogle
    case remoteFacebook
    case remoteInstagram
    case remoteDropbox
}
