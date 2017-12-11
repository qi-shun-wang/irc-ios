//
//  IRCGameModeViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import SnapKit

class IRCGameModeViewController: UIViewController,Rotatable {
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var arrowTouchPad: UIButton!
    
    @IBAction func exitAction(_ sender: UIButton) {
        
        dismiss(animated: true) {
            self.resetToPortrait()
        }
    }

}
