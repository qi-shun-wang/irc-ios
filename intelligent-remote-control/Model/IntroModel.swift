//
//  IntroModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/5.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class IntroModel : NSObject {
    var imageName:String
    var introDescription:String
    
    init(imageName:String, introDescription:String) {
        self.imageName = imageName
        self.introDescription = introDescription
    }
    
}
