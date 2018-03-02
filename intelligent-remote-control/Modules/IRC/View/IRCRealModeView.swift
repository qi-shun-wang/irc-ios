//
//  IRCRealModeView.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/27.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class IRCRealModeView: UIView {
    /// The images to use for the IRC
    
    @IBOutlet weak var contentView: UIView!
    public var powerAction:(()->Void)?
//    public var powerAction:(()->Void)?
//    public var powerAction:(()->Void)?
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
        Bundle.main.loadNibNamed("IRCRealModeView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]

    }
}
