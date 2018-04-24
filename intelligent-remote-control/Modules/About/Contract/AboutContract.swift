//
//  AboutContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/4/23.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol AboutView: BaseView {
    //navigation bar
    func setupNavigationLeftItem(image named:String,title text:String)
    func setupNavigationRightItem(image named:String,title text:String)
    func setupNavigationTitle(with text:String)
    //table view
    func reloadTableList()
}

protocol AboutPresentation: BasePresentation {
    func cellInfo(forRowAt indexPath:IndexPath) -> (title:String,subtitle:String,isDisclosure:Bool,isSelectable:Bool)
    func numberOfRows(in section:Int) -> Int
    func numberOfSections() -> Int
    func didSelect(at indexPath:IndexPath)

    func dismissAbout()
}

protocol AboutUseCase: class {
    // TODO: Declare use case methods
}

protocol AboutInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol AboutWireframe: class {
    func dismissAbout()
    func presentWeb(url:String,with title:String)
}
