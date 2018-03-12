//
//  IRCNumberControlPanel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class IRCNumberControlPanel: UIView {
    
    private let nibIdentifier = "IRCNumberControlPanel"
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var dragableContainer: UIView!
    @IBOutlet var numberCollection: [UIRoundedButton]!
    @IBOutlet weak var deleteBtn: UIRoundedButton!
    
    lazy var maximumContainerHeight:CGFloat = 3*frame.height/5
    lazy var visibleCenterBoundarY:CGFloat = maximumContainerHeight/2
    lazy var panGesture = UIPanGestureRecognizer()
    var numberDispatchAction:ButtonCallback?
    var deleteDispatchAction:Callback?
    
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
    
    @IBAction func numberAction(_ sender: UIButton) {
        numberDispatchAction?(sender)
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        deleteDispatchAction?()
    }
    
    @IBAction func exitAction(_ sender: UIButton) {
        isClose = true
    }
    
    private func setupCollectionOfNumber(){
        numberCollection.forEach { (btn) in
            btn.setTitle("\(btn.tag)", for: .normal)
        }
    }
    
    private func setupConstraints() {
        dragableContainer.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(maximumContainerHeight)
            make.centerY.equalTo(-maximumContainerHeight)
        }
        let numBtnLength:CGFloat = maximumContainerHeight/4
        numberCollection.forEach { (btn) in
            
            btn.snp.makeConstraints { (make) in
                make.height.equalTo(numBtnLength)
                make.width.equalTo(numBtnLength)
            }
            btn.layer.masksToBounds = false
            btn.layer.cornerRadius = btn.frame.width/2
        }
        deleteBtn.layer.cornerRadius = deleteBtn.frame.width/2
    }
    
    private func performCloseAnimation(){
        UIView.animate(withDuration: 0.5) {
            self.dragableContainer.center.y = -self.visibleCenterBoundarY
            self.isHidden = true
        }
    }
    
    private func performOpenAnimation(){
        UIView.animate(withDuration: 0.5) {
            self.dragableContainer.center.y = self.visibleCenterBoundarY
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
        Bundle.main.loadNibNamed(nibIdentifier, owner: self, options: nil)
        backgroundColor = UIColor(white: 0, alpha: 0)
        isOpaque = false
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        dragableContainer.isUserInteractionEnabled = true
        dragableContainer.addGestureRecognizer(panGesture)
        setupCollectionOfNumber()
        setupConstraints()
    }
    
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        guard let draggedView = sender.view else{return}
        bringSubview(toFront: draggedView)
        
        let translation = sender.translation(in: self)
        let nextCenterY = dragableContainer.center.y + translation.y
        print(translation.y,nextCenterY)
        print(sender.state.rawValue)
        if nextCenterY > 0 && sender.state == .ended {
            isClose = false
            return
        }
        if nextCenterY <= 0 && sender.state == .ended {
            isClose = true
            return
        }
        if nextCenterY*2 > maximumContainerHeight {
            return
        }
        dragableContainer.center.y = nextCenterY
        sender.setTranslation(CGPoint.zero, in: self)
    }
    
}
