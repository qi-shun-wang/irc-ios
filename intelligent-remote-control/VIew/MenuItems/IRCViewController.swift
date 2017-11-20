//
//  IRCViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class IRCViewController: UIViewController {
    
    lazy var path = Bundle.main.path(forResource: "AppState", ofType: "plist")
    var viewModel:IRCViewModel?
    @IBOutlet weak var mask:UIImageViewWithMask!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel == nil {
            viewModel = IRCViewModel(view: self)
        }
        viewModel?.setupNavigationTitle()
        viewModel?.setupNavigationBarBackground()
    }
    
    @IBAction func toggleMenu(_ sender: UIButton) {
        
        if viewModel == nil {
            viewModel = IRCViewModel(view: self)
        }
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


extension IRCViewController:IRCViewControllerProtocol{
    func openMenu() {
        slideMenuController()?.openLeft()
    }
    func renderNavigationTitle(with text: String) {
        let bar = navigationController?.navigationBar
        
        bar?.titleTextAttributes = [
            NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20),
            NSAttributedStringKey.foregroundColor: UIColor.white]
        
        navigationItem.title = text
    }
    
    func renderNavigationBarBackground() {
        let bar = navigationController?.navigationBar
        if let backgroundFrame = bar?.realNavigationBarFrame() {
            let navigationBarBackground = UIImageView(frame: backgroundFrame)
            navigationBarBackground.image = UIImage(named: "navi_bg")
            navigationBarBackground.contentMode = .scaleToFill
            view.addSubview(navigationBarBackground)
        }
        bar?.transparentNavigationBar()
    }
}

