//
//  IRCKaraokeControlPanel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/9.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class IRCKaraokeControlPanel: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var dragableContainer: UIView!
    
    @IBOutlet weak var songTerminationBtn: UIRoundedButton!
    @IBOutlet weak var songInsertionBtn: UIRoundedButton!
    
    @IBOutlet weak var broadcastConsoleBtn: UIRoundedButton!
    @IBOutlet weak var mixerConsoleBtn: UIRoundedButton!
    @IBOutlet weak var toneSwitcherBtn: UIRoundedButton!
    
    @IBOutlet weak var recordBtn: UIRoundedButton!
    @IBOutlet weak var replayBtn: UIRoundedButton!
    
    private func setupConstraints() {
        
        dragableContainer.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(maximumContainerHeight)
        }
        
        let commonHeight:CGFloat = maximumContainerHeight/3
        let commonWidth:CGFloat = UIScreen.main.bounds.width/3
        songTerminationBtn.snp.makeConstraints { (make) in
            make.height.equalTo(commonHeight)
            make.width.equalTo(commonWidth)
        }
        songInsertionBtn.snp.makeConstraints { (make) in
            make.height.equalTo(commonHeight)
            make.width.equalTo(commonWidth)
        }
        
        broadcastConsoleBtn.snp.makeConstraints { (make) in
            make.height.equalTo(commonHeight)
            make.width.equalTo(commonWidth)
        }
        
        mixerConsoleBtn.snp.makeConstraints { (make) in
            make.height.equalTo(commonHeight)
            make.width.equalTo(commonWidth)
            make.center.equalTo(dragableContainer)
        }
        
        toneSwitcherBtn.snp.makeConstraints { (make) in
            make.height.equalTo(commonHeight)
            make.width.equalTo(commonWidth)
        }
        recordBtn.snp.makeConstraints { (make) in
            make.height.equalTo(commonHeight)
            make.width.equalTo(commonWidth)
        }
        replayBtn.snp.makeConstraints { (make) in
            make.height.equalTo(commonHeight)
            make.width.equalTo(commonWidth)
        }
    }
    
    lazy var maximumContainerHeight:CGFloat = 3*frame.height/5
    lazy var visibleCenterBoundaryHeight:CGFloat = maximumContainerHeight/2
    
    lazy var panGesture = UIPanGestureRecognizer()
    var isClose:Bool = true {
        didSet{
            print(isClose)
            if isClose {
                performCloseAnimation()
            }else{
                performOpenAnimation()
            }
        }
    }
    private func performCloseAnimation(){
        UIView.animate(withDuration: 0.5) {
            self.dragableContainer.center.y = -self.maximumContainerHeight/2
            self.isHidden = true
        }
    }
    private func performOpenAnimation(){
        
        UIView.animate(withDuration: 0.5) {
            self.dragableContainer.center.y = self.maximumContainerHeight/2
            self.isHidden = false
        }
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
        Bundle.main.loadNibNamed("IRCKaraokeControlPanel", owner: self, options: nil)
        backgroundColor = UIColor(white: 0, alpha: 0)
        isOpaque = false
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        dragableContainer.isUserInteractionEnabled = true
        dragableContainer.addGestureRecognizer(panGesture)
     
        setupConstraints()
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        guard let draggedView = sender.view else{return}
        bringSubview(toFront: draggedView)
        
        let translation = sender.translation(in: self)
        let nextCenterHeight = dragableContainer.center.y + translation.y
        print(translation.y,nextCenterHeight)
        print(sender.state.rawValue)
        if nextCenterHeight > visibleCenterBoundaryHeight && sender.state == .ended {
            isClose = false
            return
        }
        if nextCenterHeight <= visibleCenterBoundaryHeight && sender.state == .ended {
            isClose = true
            return
        }
        
        if nextCenterHeight > visibleCenterBoundaryHeight {
            return
        }
        dragableContainer.center.y = nextCenterHeight
        sender.setTranslation(CGPoint.zero, in: self)
    }


}
