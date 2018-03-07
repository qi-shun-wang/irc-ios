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
    public var numAction:(()->Void)?
    public var karaokeAction:(()->Void)?
    public var volumeAction:(()->Void)?
    public var channelAction:(()->Void)?
    public var kodAction:(()->Void)?
    public var playAction:(()->Void)?
    public var menuAction:(()->Void)?
    public var backAction:(()->Void)?
    public var directAction:(()->Void)?
    public var positionDelegate:PositionDelegate? {
        didSet {
            mousePad.positionDelegate = positionDelegate
        }
    }
    @IBOutlet weak var mousePad: UIMousePadView!
    @IBAction func performPower(_ sender: UIButton) {
        powerAction?()
    }
    
    @IBAction func performNum(_ sender: UIButton) {
        numAction?()
    }
    
    @IBAction func performKaraoke(_ sender: UIButton) {
        karaokeAction?()
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
    
    @IBAction func performKOD(_ sender: UIButton) {
        kodAction?()
    }
    
    @IBAction func changeVolume(_ sender: UIButton) {
        
    }
    
    @IBAction func changeChannel(_ sender: UIButton) {
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
