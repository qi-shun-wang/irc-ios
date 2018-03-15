//
//  PlayerControlPanel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/13.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class PlayerControlPanel: UIView {

    private let nibIdentifier = "PlayerControlPanel"
    
    @IBOutlet var contentView: UIView!
    
    public var switchDispatchAction:ViewCallback?
    
    @IBAction func closeAction(_ sender: UIButton) {
        isHidden = true
    }
    
    @IBAction func switchAction(_ sender: UIButton) {
        switchDispatchAction?(self)
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
        backgroundColor = UIColor(white: 0, alpha: 0)
        isOpaque = false
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
}
