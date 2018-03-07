//
//  IRCGeneralControlPanel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/5.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class IRCGeneralControlPanel: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var section1: UIView!
    @IBOutlet weak var section2: UIView!
    @IBOutlet weak var section3: UIView!
    @IBOutlet weak var section4: UIView!
    //MARK: Section1 IBOutlet's ref
    @IBOutlet weak var powerBtn: UIButton!
    @IBOutlet weak var numBtn: UIButton!
    @IBOutlet weak var karaokeBtn: UIButton!
    @IBOutlet weak var modeSwitchBtn: UIButton!
    //MARK: Section2 IBOutlet's ref
    @IBOutlet weak var directionPad: UICircularButton!
    //MARK: Section3 IBOutlet's ref
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var playbackBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    //MARK: Section4 IBOutlet's ref
    @IBOutlet weak var volumeBtn: UIButton!
    @IBOutlet weak var kodBtn: UIButton!
    @IBOutlet var channelBtn: UIView!
    
    var screen:(h:CGFloat,w:CGFloat) {
        get{
            return (contentView.frame.height,contentView.frame.width)
        }
    }
    
    func initializeSectionContraints(){
        
        section1.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.equalTo(safeAreaLayoutGuide)
            make.right.equalTo(safeAreaLayoutGuide)
            make.height.greaterThanOrEqualTo(80)
        }
        section2.snp.makeConstraints { (make) in
            make.top.equalTo(section1.snp.bottom)
            make.left.equalTo(safeAreaLayoutGuide)
            make.right.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(section3.snp.top)
            make.height.equalTo(section2.snp.width)
        }
        section3.snp.makeConstraints { (make) in
            make.top.equalTo(section2.snp.bottom)
            make.left.equalTo(safeAreaLayoutGuide)
            make.right.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(section1)
        }
        section4.snp.makeConstraints { (make) in
            make.top.equalTo(section3.snp.bottom)
            make.left.equalTo(safeAreaLayoutGuide)
            make.right.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(section1).multipliedBy(1.5)
        }
        
        directionPad.snp.makeConstraints { (make) in
            make.center.equalTo(section2)
            make.height.equalTo(directionPad.snp.width)
            make.leadingMargin.equalTo(16)
            make.topMargin.equalTo(16)
        }
        
        powerBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(powerBtn.snp.width)
            make.topMargin.equalToSuperview()
            make.centerX.equalTo(numBtn.snp.centerX).offset(-screen.w/4)
            
        }
        numBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(numBtn.snp.width)
            make.topMargin.equalToSuperview()
            make.centerX.greaterThanOrEqualToSuperview().offset(-screen.w/8)
        }
        karaokeBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(karaokeBtn.snp.width)
            make.topMargin.equalToSuperview()
            make.centerX.greaterThanOrEqualToSuperview().offset(screen.w/8)
        }
        modeSwitchBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(modeSwitchBtn.snp.width)
            make.topMargin.equalToSuperview()
            make.centerX.equalTo(karaokeBtn.snp.centerX).offset(screen.w/4)
        }
        
        menuBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-16)
            make.height.equalTo(menuBtn.snp.width)
            make.topMargin.equalToSuperview().offset(-16)
            make.centerX.equalTo(playbackBtn.snp.centerX).offset(-screen.w/3)
        }
        playbackBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(playbackBtn.snp.width)
            make.topMargin.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        backBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-16)
            make.height.equalTo(backBtn.snp.width)
            make.topMargin.equalToSuperview().offset(-16)
            make.centerX.equalTo(playbackBtn.snp.centerX).offset(screen.w/3)
        }
        
        
        volumeBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(volumeBtn.snp.width)
            make.topMargin.equalToSuperview()
            make.centerX.equalTo(kodBtn.snp.centerX).offset(-screen.w/3)
        }
        kodBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(kodBtn.snp.width)
            make.topMargin.equalTo(4)
            make.centerX.equalToSuperview()
        }
        channelBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(channelBtn.snp.width)
            make.topMargin.equalToSuperview()
            make.centerX.equalTo(kodBtn.snp.centerX).offset(screen.w/3)
        }
    }
    
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
    public var codeSender:CodeSender? {
        didSet {
            directionPad.sender = codeSender
        }
    }
    
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
        Bundle.main.loadNibNamed("IRCGeneralControlPanel", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        initializeSectionContraints()
    }

}
