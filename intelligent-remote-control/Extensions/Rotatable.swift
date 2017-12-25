//
//  Rotatable.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/22.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

protocol Rotatable: AnyObject {
    func resetToPortrait()
}

extension Rotatable where Self: UIViewController {
    func resetToPortrait() {
        UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
    }
}

