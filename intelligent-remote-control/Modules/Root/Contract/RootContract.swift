//
//  RootContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

protocol RootView: class {
    // TODO: Declare view methods
    func setupRootStyle()
}

protocol RootPresentation: class {
    // TODO: Declare presentation methods
    func awakeFromNib()
    
}

protocol RootUseCase: class {
    // TODO: Declare use case methods
}

protocol RootInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol RootWireframe: class {
    // TODO: Declare wireframe methods
    func presentRootScreen(in window:UIWindow)
}
