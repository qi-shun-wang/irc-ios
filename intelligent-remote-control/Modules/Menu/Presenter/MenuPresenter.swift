//
//  MenuPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MenuPresenter {
    fileprivate let MenuCellIdentifier = "MenuCell"
    // MARK: Properties
    
    weak var view: MenuView?
    var router: MenuWireframe?
    var interactor: MenuUseCase?
    
    fileprivate var items:[MenuModel] = [] {
        didSet {
            view?.updateMenuTable()
        }
        
    }
    
}

extension MenuPresenter: MenuPresentation {
    // TODO: implement presentation methods
    
    func viewDidLoad() {
        interactor?.searchConnections()
    }
    
    func numberOfRowsInSection(_ section:Int) -> Int {
        return items.count
    }
    
    func cellForRowAt(_ indexPath:IndexPath) -> (identifier:String,icon:String,title:String,subTitle:String,connectionStatus:String) {
        let item = items[indexPath.row]
        let data = (MenuCellIdentifier,item.iconName,item.title,item.subTitle,item.connectionStatus)
        return data
    }
    
    func didSelectRowAt(_ indexPath:IndexPath){
        
        
    }
}

extension MenuPresenter: MenuInteractorOutput {
    func didFetchConnections(_ connections: [KODConnection]) {
        var menu:[MenuModel] = []
        connections.forEach { (connection) in
            menu.append(connection.getModel())
        }
        items = menu
    }
    
    func didNotFetchConnections(message: String) {
        
    }
    
    // TODO: implement interactor output methods
}
