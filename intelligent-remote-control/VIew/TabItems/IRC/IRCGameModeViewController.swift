//
//  IRCGameModeViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import SnapKit

protocol IRCGameModeViewControllerDelegate:class {
    func didExit()
}
class IRCGameModeViewController: UIViewController,Rotatable {
    weak var delegate:IRCGameModeViewControllerDelegate?
    @IBOutlet weak var exitBtn: UIButton!
    
    @IBOutlet weak var touchPadContainer: UIView!
    @IBOutlet weak var rockerContainer: UIView!
    @IBOutlet weak var centerDotContainer: UIView!
    @IBOutlet weak var supportDotContainer: UIView!
    
    @IBOutlet weak var arrowTouchPad: UICircularButton!
    
    @IBOutlet weak var rockerPad: JoyStickView!
    
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var selectLbl: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var startLbl: UILabel!
    
    @IBOutlet weak var xBtn: UIButton!
    @IBOutlet weak var yBtn: UIButton!
    @IBOutlet weak var bBtn: UIButton!
    @IBOutlet weak var aBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        touchPadContainer.snp.remakeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(view.snp.width).multipliedBy(0.35)
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        rockerContainer.snp.remakeConstraints { (make) in
            make.leading.equalTo(touchPadContainer.snp.trailing).offset(16)
            make.trailing.equalTo(centerDotContainer.snp.leading)
            make.bottom.equalTo(view.snp.bottom)
            make.top.equalTo(view.snp.top)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(view.snp.width).multipliedBy(0.15)
        }
        
        
        centerDotContainer.snp.remakeConstraints { (make) in
            make.width.equalTo(view.snp.width).multipliedBy(0.15)
            make.centerY.equalTo(view.snp.centerY)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(rockerContainer.snp.trailing)
            make.trailing.equalTo(supportDotContainer.snp.leading)
        }
        
        supportDotContainer.snp.remakeConstraints { (make) in
            make.width.equalTo(view.snp.width).multipliedBy(0.35)
            make.centerY.equalTo(view.snp.centerY)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(centerDotContainer.snp.trailing)
            make.trailing.equalTo(view.snp.trailing)
        }
        
        arrowTouchPad.snp.remakeConstraints { (make) in
            make.center.equalTo(touchPadContainer.snp.center)
            make.width.equalTo(arrowTouchPad.snp.height)
            make.width.equalTo(touchPadContainer.snp.width).multipliedBy(0.9)
        }
        
        rockerPad.movable = false
        rockerPad.snp.remakeConstraints { (make) in
            make.centerX.equalTo(rockerContainer.snp.centerX)
            make.bottom.equalTo(rockerContainer.snp.bottom).offset(-16)
            make.width.equalTo(rockerPad.snp.height)
            make.width.equalTo(rockerContainer.snp.width).multipliedBy(0.9)
        }
        
        
        selectBtn.snp.remakeConstraints { (make) in
            make.width.equalTo(selectBtn.snp.height)
            make.width.equalTo(centerDotContainer.snp.width).multipliedBy(0.8)
            make.centerY.equalTo(rockerContainer.snp.centerY).offset(-32)
            make.trailing.equalTo(rockerContainer.snp.trailing)
        }
        
        selectLbl.snp.remakeConstraints { (make) in
            make.width.equalTo(selectBtn.snp.width)
            make.height.equalTo(15)
            make.bottom.equalTo(selectBtn.snp.bottom)
            make.centerX.equalTo(selectBtn.snp.centerX)
        }
        
        startBtn.snp.remakeConstraints { (make) in
            make.width.equalTo(startBtn.snp.height)
            make.width.equalTo(centerDotContainer.snp.width).multipliedBy(0.8)
            make.centerY.equalTo(centerDotContainer.snp.centerY).offset(-32)
            make.leading.equalTo(centerDotContainer.snp.leading)
        }
        
        
        startLbl.snp.remakeConstraints { (make) in
            make.width.equalTo(startBtn.snp.width)
            make.height.equalTo(15)
            make.bottom.equalTo(startBtn.snp.bottom)
            make.centerX.equalTo(startBtn.snp.centerX)
        }
        
        let padding:CGFloat = supportDotContainer.frame.width/3
        yBtn.snp.remakeConstraints { (make) in
            make.width.equalTo(yBtn.snp.height)
            make.width.equalTo(supportDotContainer.snp.width).multipliedBy(0.3)
            make.centerX.equalTo(supportDotContainer.snp.centerX)
            make.centerY.equalTo(supportDotContainer.snp.centerY).offset(-padding)
        }
        aBtn.snp.remakeConstraints { (make) in
            make.width.equalTo(aBtn.snp.height)
            make.width.equalTo(supportDotContainer.snp.width).multipliedBy(0.3)
            make.centerX.equalTo(supportDotContainer.snp.centerX)
            make.centerY.equalTo(supportDotContainer.snp.centerY).offset(padding)
        }
        
        bBtn.snp.remakeConstraints { (make) in
            make.width.equalTo(bBtn.snp.height)
            make.width.equalTo(supportDotContainer.snp.width).multipliedBy(0.3)
            make.centerY.equalTo(supportDotContainer.snp.centerY)
            make.centerX.equalTo(supportDotContainer.snp.centerX).offset(padding)
        }
        xBtn.snp.remakeConstraints { (make) in
            make.width.equalTo(xBtn.snp.height)
            make.width.equalTo(supportDotContainer.snp.width).multipliedBy(0.3)
            make.centerY.equalTo(supportDotContainer.snp.centerY)
            make.centerX.equalTo(supportDotContainer.snp.centerX).offset(-padding)
        }
    }
    
    @IBAction func exitAction(_ sender: UIButton) {
        delegate?.didExit()
        dismiss(animated: true) {
            
            self.resetToPortrait()
        }
    }
    
}
