//
//  IRCNumberControlPanel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class IRCNumberControlPanel: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var dragableContainer: UIView!
    lazy var maximumContainerHeight:CGFloat = 3*frame.height/5
    lazy var visibleBoundaryHeight:CGFloat = 2*frame.height/5
//    lazy var maximumVisibleHeight:CGFloat = 2*frame.height/5
//    lazy var minimumVisibleHeight:CGFloat = frame.height/5
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
            self.dragableContainer.frame.size.height = 4
        }
    }
    private func performOpenAnimation(){
        
        UIView.animate(withDuration: 0.5) {
           self.dragableContainer.frame.size.height = self.maximumContainerHeight
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
        Bundle.main.loadNibNamed("IRCNumberControlPanel", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.draggedView(_:)))
        dragableContainer.isUserInteractionEnabled = true
        dragableContainer.addGestureRecognizer(panGesture)
        dragableContainer.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
        }
        
    }
    override func awakeFromNib() {
//        performOpenAnimation()
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        performOpenAnimation()
    }
    override func layoutSubviews() {
        
    }
    @objc func draggedView(_ sender:UIPanGestureRecognizer){
        guard let draggedView = sender.view else{return}
        bringSubview(toFront: draggedView)
        
        let translation = sender.translation(in: self)
        let nextHeight = draggedView.frame.size.height + translation.y
        print(translation.y,nextHeight)
        print(sender.state.rawValue)
        if nextHeight > visibleBoundaryHeight && sender.state == .ended {
            isClose = false
            return
        }
        if nextHeight <= visibleBoundaryHeight && sender.state == .ended {
            isClose = true
            return
        }
        draggedView.frame.size.height = nextHeight
        
        //        dragableContainer.center = CGPoint(x: dragableContainer.center.x + translation.x, y: dragableContainer.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
    }
    
}
