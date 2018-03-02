//
//  MoreContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

protocol MoreView: BaseView {
    // TODO: Declare view methods
}

protocol MorePresentation: BasePresentation {
    // TODO: Declare presentation methods
    func didSelectItem(at indexPath:IndexPath)
    func numberOfItems() -> Int
    func cellInfo(at indexPath:IndexPath)->(icon:String,title:String)
}

protocol MoreUseCase: class {
    // TODO: Declare use case methods
}

protocol MoreInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol MoreWireframe: class {
    // TODO: Declare wireframe methods
    func presentMediaShare()
}
protocol MoreTypeProtocol {
    func getTitle() -> String
    func getImageName() -> String
}
