//
//  IntroductionContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

protocol IntroductionView: BaseView {
    // TODO: Declare view methods
    func hideExit()
    func showExit()
    func render(_ currentPage:Int)
    func render(with description: String, _ imageName: String)
    func setupPage(_ total:Int)
}

protocol IntroductionPresentation: BasePresentation {
    // TODO: Declare presentation methods
    func exit()
    func swipeLeft()
    func swipeRight()
}

protocol IntroductionUseCase: class {
    // TODO: Declare use case methods
}

protocol IntroductionInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol IntroductionWireframe: class {
    // TODO: Declare wireframe methods
    func changeMainController()
}
