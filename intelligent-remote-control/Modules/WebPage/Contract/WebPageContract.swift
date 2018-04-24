//
//  WebPageContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/4/24.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol WebPageView: BaseView {
    // TODO: Declare view methods
    func setupWeb(url:String)
}

protocol WebPagePresentation: BasePresentation {

}

protocol WebPageUseCase: class {
    // TODO: Declare use case methods
}

protocol WebPageInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol WebPageWireframe: class {
    // TODO: Declare wireframe methods
}
