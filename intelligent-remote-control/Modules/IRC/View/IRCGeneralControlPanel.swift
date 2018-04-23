//
//  IRCGeneralControlPanel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/5.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class IRCGeneralControlPanel: UIView {
    
    private let nibIdentifier = "IRCGeneralControlPanel"
    
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
    @IBOutlet weak var volumeBtn: DoubleSideButton!
    @IBOutlet weak var kodBtn: UIButton!
    @IBOutlet var channelBtn: DoubleSideButton!
    @IBOutlet weak var volumeLbl: UILabel!
    @IBOutlet weak var channelLbl: UILabel!
    
    public var powerAction:Callback?
    public var switchAction:ButtonCallback?
    public var numAction:Callback?
    public var karaokeAction:Callback?
    public var volumeAction:BooleanCallback?
    public var channelAction:BooleanCallback?
    public var kodAction:Callback?
    public var playbackAction:Callback?
    public var menuAction:Callback?
    public var backAction:Callback?
    
    public var codeSender:CodeSender? {
        didSet {
            directionPad.sender = codeSender
        }
    }
    
    var screen:(h:CGFloat,w:CGFloat) {
        get{
            return (contentView.frame.height,contentView.frame.width)
        }
    }
    
    private func actionBinding(){
        channelBtn.downSideAction = {
            self.channelAction?(false)
        }
        channelBtn.upSideAction = {
            self.channelAction?(true)
        }
        volumeBtn.downSideAction = {
            self.volumeAction?(false)
        }
        volumeBtn.upSideAction = {
            self.volumeAction?(true)
        }
    }
    
    private func initializeSectionContraints(){
        let section1Ratio:CGFloat = 1
        let section2Ratio:CGFloat = 3.5
        let section3Ratio:CGFloat = 1
        let section4Ratio:CGFloat = 2
        let screenHeightDivisor:CGFloat = section1Ratio + section2Ratio + section3Ratio + section4Ratio
        
        section1.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(safeAreaLayoutGuide)
                make.left.equalTo(safeAreaLayoutGuide)
                make.right.equalTo(safeAreaLayoutGuide)
            } else {
                // Fallback on earlier versions
                make.top.equalTo(layoutMarginsGuide)
                make.left.equalTo(layoutMarginsGuide)
                make.right.equalTo(layoutMarginsGuide)
            }
            
            make.height.equalTo(section1Ratio*screen.h/screenHeightDivisor)
        }
        section2.snp.makeConstraints { (make) in
            make.top.equalTo(section1.snp.bottom)
            if #available(iOS 11.0, *) {
                make.left.equalTo(safeAreaLayoutGuide)
                make.right.equalTo(safeAreaLayoutGuide)
            } else {
                // Fallback on earlier versions
                make.left.equalTo(layoutMarginsGuide)
                make.right.equalTo(layoutMarginsGuide)
            }
            make.height.equalTo(section2Ratio*screen.h/screenHeightDivisor)
        }
        section3.snp.makeConstraints { (make) in
            make.top.equalTo(section2.snp.bottom)
            if #available(iOS 11.0, *) {
                make.left.equalTo(safeAreaLayoutGuide)
                make.right.equalTo(safeAreaLayoutGuide)
            } else {
                // Fallback on earlier versions
                make.left.equalTo(layoutMarginsGuide)
                make.right.equalTo(layoutMarginsGuide)
            }
            
            make.height.equalTo(section3Ratio*screen.h/screenHeightDivisor)
        }
        section4.snp.makeConstraints { (make) in
            make.top.equalTo(section3.snp.bottom)
            if #available(iOS 11.0, *) {
                make.left.equalTo(safeAreaLayoutGuide)
                make.right.equalTo(safeAreaLayoutGuide)
                make.bottom.equalTo(safeAreaLayoutGuide).offset(-8)
            } else {
                // Fallback on earlier versions
                make.left.equalTo(layoutMarginsGuide)
                make.right.equalTo(layoutMarginsGuide)
                make.bottom.equalTo(layoutMarginsGuide).offset(-8)
            }
            
            make.height.equalTo(section4Ratio*screen.h/screenHeightDivisor)
        }
        
        directionPad.snp.makeConstraints { (make) in
            make.center.equalTo(section2)
            make.height.equalTo(directionPad.snp.width)
            make.topMargin.equalTo(16)
        }
        
        powerBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(powerBtn.snp.width)
            make.topMargin.equalToSuperview().offset(4)
            make.centerX.equalTo(numBtn.snp.centerX).offset(-screen.w/4)
            
        }
        numBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(numBtn.snp.width)
            make.topMargin.equalToSuperview().offset(4)
            make.centerX.greaterThanOrEqualToSuperview().offset(-screen.w/8)
        }
        karaokeBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(karaokeBtn.snp.width)
            make.topMargin.equalToSuperview().offset(4)
            make.centerX.greaterThanOrEqualToSuperview().offset(screen.w/8)
        }
        modeSwitchBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(modeSwitchBtn.snp.width)
            make.topMargin.equalToSuperview().offset(4)
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
        volumeLbl.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(volumeBtn.snp.width).dividedBy(2)
            make.height.equalTo(volumeBtn.snp.height)
            make.topMargin.equalToSuperview()
            make.centerX.equalTo(kodBtn.snp.centerX).offset(-screen.w/3)
        }
        kodBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(kodBtn.snp.width)
            make.topMargin.equalTo(16)
            make.centerX.equalToSuperview()
        }
        channelBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(channelBtn.snp.width)
            make.topMargin.equalToSuperview()
            make.centerX.equalTo(kodBtn.snp.centerX).offset(screen.w/3)
        }
        channelLbl.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalTo(channelBtn.snp.width).dividedBy(2)
            make.height.equalTo(channelBtn.snp.width)
            make.topMargin.equalToSuperview()
            make.centerX.equalTo(kodBtn.snp.centerX).offset(screen.w/3)
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
    @IBAction func performPlayback(_ sender: UIButton) {
        playbackAction?()
    }
    @IBAction func performBack(_ sender: UIButton) {
        backAction?()
    }
    
    @IBAction func performKOD(_ sender: UIButton) {
        kodAction?()
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
        initializeSectionContraints()
        actionBinding()
    }
    
}
