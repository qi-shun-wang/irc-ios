//
//  PlayerCell.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/9.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumArtImageView: UIImageView!
    @IBOutlet weak var slidableProgressBar: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var playbackBtn: UIButton!
    @IBOutlet weak var backwardBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var castBtn: UIButton!
    var dragging:(()->Void)?
    var finished:((_ value:Float)->Void)?
    var sliderHasFinishedTracking: Bool = true
    @IBAction func dragAction(_ sender: UISlider) {
        
        if sender.isTracking {
            sliderHasFinishedTracking = false
            dragging?()
        }else {
            if sliderHasFinishedTracking {
                
            } else {
                sliderHasFinishedTracking = true
                finished?(sender.value)
            }
            
        }
    }
    var volumeDragging:(()->Void)?
    var volumeFinished:((_ value:Float)->Void)?
    var volumeSliderHasFinishedTracking: Bool = true
    @IBAction func volumeAction(_ sender: UISlider) {
        if sender.isTracking {
            volumeSliderHasFinishedTracking = false
            volumeDragging?()
        }else {
            if volumeSliderHasFinishedTracking {
                
            } else {
                volumeSliderHasFinishedTracking = true
                volumeFinished?(sender.value)
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        slidableProgressBar.setThumbImage(UIImage(named:"slider_thumb_normal_icon"), for: .normal)
        slidableProgressBar.setThumbImage(UIImage(named:"slider_thumb_highlighted_icon"), for: .highlighted)
        
        
        slidableProgressBar.setMinimumTrackImage(UIColor.red.convertImage(), for: .highlighted)
        
    }
}
