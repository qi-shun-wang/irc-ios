//
//  IRCNormalControlPanel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/5.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class IRCNormalControlPanel: UIView {
    
    private let nibIdentifier = "IRCNormalControlPanel"
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var directionPad: UICircularButton!
    
    public var powerAction:Callback?
    public var switchAction:ButtonCallback?
    public var homeAction:Callback?
    public var volumeAction:BooleanCallback?
    public var menuAction:Callback?
    public var backAction:Callback?
    
    public var codeSender:CodeSender? {
        didSet {
            directionPad.sender = codeSender
        }
    }
    
    @IBAction func performPower(_ sender: UIButton) {
        powerAction?()
    }
    
    @IBAction func performSwitch(_ sender: UIButton) {
        switchAction?(sender)
    }
    
    @IBAction func performMenu(_ sender: UIButton) {
        menuAction?()
    }
    
    @IBAction func performBack(_ sender: UIButton) {
        backAction?()
    }
    
    @IBAction func increaseVolume(_ sender: UIButton) {
        volumeAction?(true)
    }
    
    @IBAction func decreaseVolume(_ sender: UIButton) {
        volumeAction?(false)
    }
    
    @IBAction func performHome(_ sender: UIButton) {
        homeAction?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    /**
     Common initialization of view. Creates UIButton instances for base and handle.
     */
    private func initialize(){
        Bundle.main.loadNibNamed(nibIdentifier, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
         contentView.backgroundColor = UIColor.main_background_color
    }
    
}
