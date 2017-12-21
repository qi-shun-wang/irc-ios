//
//  WebBrowserContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

protocol WebBrowserView: BaseView {
    // TODO: Declare view methods
    //navigation bar
    func setupNavigationLeftItem(image named:String,title text:String)
    func setupNavigationRightItem(image named:String,title text:String)
    
}

protocol WebBrowserPresentation: BasePresentation {
    // TODO: Declare presentation methods
    func presentBookmark()
}

protocol WebBrowserUseCase: class {
    // TODO: Declare use case methods
}

protocol WebBrowserInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol WebBrowserWireframe: class {
    // TODO: Declare wireframe methods
    func presentWebBookmark()
}
