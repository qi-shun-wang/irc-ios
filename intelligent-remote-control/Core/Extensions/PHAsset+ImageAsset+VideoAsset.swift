//
//  PHAsset+ImageAsset+VideoAsset.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/10.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Photos

extension PHAsset : ImageAsset, VideoAsset, SlowMotion {}
extension AVURLAsset : VideoAsset {}
