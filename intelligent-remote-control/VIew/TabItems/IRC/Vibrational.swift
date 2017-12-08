//
//  Vibrational.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import SnapKit
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


public protocol CornerRound : class {
    func setupCorner(radius:CGFloat)
}
extension CornerRound where Self: UIView {
    
    func setupCorner(radius:CGFloat = 5){
        layer.cornerRadius = radius
    }
}

class UIRoundButton:UIButton,CornerRound {
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCorner(radius: 5)
        let heightPercentageOfImage:CGFloat = 0.7
        let heightPercentageOfLabel:CGFloat = 1 - heightPercentageOfImage
        let padding:CGFloat = 8
        
        titleLabel!.snp.remakeConstraints({ (make) in
            make.trailing.equalTo(snp.trailing)
            make.bottom.equalTo(snp.bottom)
            make.leading.equalTo(snp.leading)
            make.height.equalTo(snp.height).multipliedBy(heightPercentageOfLabel)
        })
        imageView!.snp.remakeConstraints({ (make) in
            make.trailing.equalTo(snp.trailing).offset(-padding)
            make.top.equalTo(snp.top).offset(padding)
            make.leading.equalTo(snp.leading).offset(padding)
            make.height.equalTo(snp.height).multipliedBy(heightPercentageOfImage).offset(-padding)
        })
        titleLabel?.textAlignment = .center
        imageView?.contentMode = .scaleAspectFit
    }
}


