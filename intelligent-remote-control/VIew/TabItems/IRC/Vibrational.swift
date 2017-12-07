//
//  Vibrational.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit
import AVFoundation

public protocol Vibrational: class {
    var delegate:VibrationalViewDelegate? {get set}
    func handleVibration(with generator:UIImpactFeedbackGenerator)
    
}

extension Vibrational where Self: UIView {
    
    func handleVibration(with generator:UIImpactFeedbackGenerator = UIImpactFeedbackGenerator(style:.heavy)){
         generator.impactOccurred()
         delegate?.viewDidVibrate(on: self)
    }
}

public protocol VibrationalViewDelegate{
    func viewDidVibrate(on view:UIView)
}


