//
//  CloudDriveViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class CloudDriveViewController: BaseViewController {
    
    lazy var path = Bundle.main.path(forResource: "AppState", ofType: "plist")
    
    override func viewDidLoad() {
        viewModel = CloudDriveViewModel(view: self)
        super.viewDidLoad()
    }
    
    @IBAction func toggleMenu(_ sender: UIButton) {
        viewModel?.openMenu()
    }
    @IBAction func test_menu_login_header(_ sender: UIButton) {
        test_helper(isSignIn:true)
    }
    @IBAction func test_menu_logout_header(_ sender: Any) {
        test_helper(isSignIn:false)
        
    }
    func test_helper(isSignIn:Bool){
        let state = AppState.shared
        state.load(filePath: path)
        state.stateMap["isSignIn"] = isSignIn
        state.update(filePath: path)
        
    }
}

extension CloudDriveViewController: CloudDriveViewControllerProtocol {}