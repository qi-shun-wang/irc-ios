//
//  DLNAMediaGeneratorError.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/10.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

enum DLNAMediaGeneratorError : Error {
    case imageGeneratorBroken
    case videoGeneratorBroken
    case slowMotionGeneratorBroken
    
    case wrongImagePHAssetType
    case wrongVideoPHAssetType
    case wrongSlowMotionPHAssetType
    case wrongMusicAssetType
    
    case wrongVideoAVAssetType
    case wrongSlowMotionAVAssetType
    
    case unableToCreateExporter
    case failureGeneratedMusicURL
}
