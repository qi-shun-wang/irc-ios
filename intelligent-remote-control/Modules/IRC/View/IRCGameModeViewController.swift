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
    func didMovedJoystick(angle:CGFloat, displacement:CGFloat)
    func dispatchActionX()
    func dispatchActionY()
    func dispatchActionA()
    func dispatchActionB()
    func dispatchActionSelect()
    func dispatchActionStart()
    func dispatchGame(state:PerformState, code:SendCode)
    
}

class IRCGameModeViewController: UIViewController,Rotatable ,CodeSender {
    //CodeSender
    func dispatch(state: PerformState, code: SendCode) {
        switch code {
        case .KEYCODE_DPAD_DOWN:delegate?.dispatchGame(state: state, code: SendCode.GAME_DPAD_DOWN)
        case .KEYCODE_DPAD_UP:delegate?.dispatchGame(state: state, code: SendCode.GAME_DPAD_UP)
        case .KEYCODE_DPAD_LEFT:delegate?.dispatchGame(state: state, code: SendCode.GAME_DPAD_LEFT)
        case .KEYCODE_DPAD_RIGHT:delegate?.dispatchGame(state: state, code: SendCode.GAME_DPAD_RIGHT)
        default:return
        }
        
    }
    
    weak var delegate:IRCGameModeViewControllerDelegate?
    @IBOutlet weak var exitBtn: UIButton!
    
    @IBOutlet weak var touchPadContainer: UIView!
    @IBOutlet weak var centerDotContainer: UIView!
    @IBOutlet weak var supportDotContainer: UIView!
    
    @IBOutlet weak var arrowTouchPad: UICircularButton!
    
    @IBOutlet weak var joyStick: JoyStickView!
    
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var selectLbl: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var startLbl: UILabel!
    
    @IBOutlet weak var xBtn: UIButton!
    @IBOutlet weak var yBtn: UIButton!
    @IBOutlet weak var bBtn: UIButton!
    @IBOutlet weak var aBtn: UIButton!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBAction func dispatchActionX(_ sender: UIButton) {
        delegate?.dispatchActionX()
    }
    
    @IBAction func dispatchActionY(_ sender: UIButton) {
        delegate?.dispatchActionY()
    }
    
    @IBAction func dispatchActionB(_ sender: UIButton) {
        delegate?.dispatchActionB()
    }
    
    @IBAction func dispatchActionA(_ sender: UIButton) {
        delegate?.dispatchActionA()
    }
    
    @IBAction func dispatchActionSelect(_ sender: UIButton) {
        delegate?.dispatchActionSelect()
    }
    
    @IBAction func dispatchActionStart(_ sender: UIButton) {
        delegate?.dispatchActionStart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        joyStick.monitor = {(angle,displacement) in
            self.delegate?.didMovedJoystick(angle: angle, displacement: displacement)
        }
        arrowTouchPad.sender = self
        view.backgroundColor = UIColor.main_background_color
        logo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.width.equalToSuperview().dividedBy(10)
            make.height.equalToSuperview().dividedBy(10)
        }
        touchPadContainer.snp.remakeConstraints { (make) in
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(view.snp.width).multipliedBy(0.35)
            make.top.equalTo(view.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.bottom.equalTo(view.snp.bottom)
        }
        centerDotContainer.snp.remakeConstraints { (make) in
            make.width.equalTo(view.snp.width).multipliedBy(0.3)
            make.centerY.equalTo(view.snp.centerY)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(touchPadContainer.snp.trailing)
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
        
        joyStick.snp.remakeConstraints { (make) in
            make.centerX.equalTo(centerDotContainer.snp.centerX).multipliedBy(0.75)
            make.bottom.equalTo(centerDotContainer.snp.bottom).offset(-16)
            make.width.equalTo(joyStick.snp.height)
            make.width.equalTo(centerDotContainer.snp.width).multipliedBy(0.5)
        }
        
        
        selectBtn.snp.remakeConstraints { (make) in
            make.width.equalTo(startBtn.snp.height)
            make.width.equalTo(centerDotContainer.snp.width).multipliedBy(0.5)
            make.centerY.equalTo(centerDotContainer.snp.centerY).offset(-32)
            make.leading.equalTo(centerDotContainer.snp.leading)
        }
        
        selectLbl.snp.remakeConstraints { (make) in
            make.width.equalTo(startBtn.snp.width)
            make.height.equalTo(15)
            make.bottom.equalTo(startBtn.snp.bottom)
            make.centerX.equalTo(startBtn.snp.centerX)
        }
        
        startBtn.snp.remakeConstraints { (make) in
            make.width.equalTo(selectBtn.snp.height)
            make.width.equalTo(centerDotContainer.snp.width).multipliedBy(0.5)
            make.centerY.equalTo(centerDotContainer.snp.centerY).offset(-32)
            make.trailing.equalTo(centerDotContainer.snp.trailing)
        }
        
        
        startLbl.snp.remakeConstraints { (make) in
            make.width.equalTo(selectBtn.snp.width)
            make.height.equalTo(15)
            make.bottom.equalTo(selectBtn.snp.bottom)
            make.centerX.equalTo(selectBtn.snp.centerX)
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
