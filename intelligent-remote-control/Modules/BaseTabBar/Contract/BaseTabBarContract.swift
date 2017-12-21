//
//  BaseTabBarContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

protocol BaseTabBarView: class {
    // TODO: Declare view methods
}

protocol BaseTabBarPresentation: class {
    // TODO: Declare presentation methods
    func presentTabs()
}

protocol BaseTabBarUseCase: class {
    // TODO: Declare use case methods
}

protocol BaseTabBarInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol BaseTabBarWireframe: class {
    // TODO: Declare wireframe methods
    func presentTabs()
}
