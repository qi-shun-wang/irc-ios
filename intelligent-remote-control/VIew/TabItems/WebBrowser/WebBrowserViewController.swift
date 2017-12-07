//
//  WebBrowserViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/5.
//  Copyright © 2017年 ising99. All rights reserved.
//

import SnapKit

class WebBrowserViewController: BaseViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var refreshBtn: UIButton!
    
    
    @IBOutlet weak var topComponent: UIView!
    
    @IBOutlet weak var touchPad: UITouchPadView!
    @IBOutlet weak var webURLInput: UITextField!
    @IBOutlet weak var okBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webURLInput.snp.remakeConstraints { (make) in
            make.centerY.equalTo(okBtn.snp.centerY)
            make.height.equalTo(okBtn.snp.height).multipliedBy(0.5)
            make.leading.equalTo(view.snp.leading).offset(8)
            make.trailing.equalTo(favoriteBtn.snp.trailing)
        }
        okBtn.snp.remakeConstraints { (make) in
            make.top.equalTo(topComponent.snp.bottom)
            make.trailing.equalTo(refreshBtn.snp.trailing)
            make.height.equalTo(refreshBtn.snp.height)
            make.width.equalTo(refreshBtn.snp.width)
        }
        
        
        touchPad.snp.remakeConstraints { (make) in
            make.top.equalTo(okBtn.snp.bottom).offset(16)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.bottom.equalTo(view.snp.bottom).offset(-16 - (tabBarController?.tabBar.bounds.height ?? 0))
            
        }
    }
    

}

extension WebBrowserViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}
