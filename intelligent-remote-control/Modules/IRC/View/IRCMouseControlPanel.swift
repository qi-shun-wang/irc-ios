//
//  IRCMouseControlPanel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/5.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class IRCMouseControlPanel: UIView {
    
    @IBOutlet weak var contentView: UIView!
    public var powerAction:(()->Void)?
    public var switchAction:ButtonCallback?
    public var volumeAction:BooleanCallback?
    public var menuAction:(()->Void)?
    public var homeAction:(()->Void)?
    public var backAction:(()->Void)?
    
    public var positionDelegate:PositionDelegate? {
        didSet {
            mousePad.positionDelegate = positionDelegate
        }
    }
    @IBOutlet weak var mousePad: UIMousePadView!
    @IBAction func performPower(_ sender: UIButton) {
        powerAction?()
    }
    
    @IBAction func performHome(_ sender: UIButton) {
        homeAction?()
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
        Bundle.main.loadNibNamed("IRCMouseControlPanel", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
    }
    
    
}
