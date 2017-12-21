//
//  WebBrowserViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class WebBrowserViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var topComponent: UIView!
    @IBOutlet weak var touchPad: UITouchPadView!
    @IBOutlet weak var webURLInput: UITextField!
    @IBOutlet weak var okBtn: UIButton!
    
    @IBAction func presentBookmark(_ sender: UIButton) {
        presenter?.presentBookmark()
    }

     var presenter: WebBrowserPresentation?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupSubviewsLayout()
    }
    
    private func setupSubviewsLayout(){
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
    
    
    override func setupNavigationLeftItem(image named: String, title text: String) {
        let button = UIButton()
        button.setImage(UIImage(named: named), for: .normal)
        button.setTitle(text, for: .normal)
        button.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        button.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    override func setupNavigationRightItem(image named: String, title text: String) {
        let buttonR = UIButton()
        buttonR.sizeToFit()
        buttonR.setImage(UIImage(named: named), for: .normal)
        buttonR.addTarget(self, action: #selector(openQRScanner), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonR)
    }
}


extension WebBrowserViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension WebBrowserViewController: WebBrowserView {
// TODO: implement view output methods
    
}
