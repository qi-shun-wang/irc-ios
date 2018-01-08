//
//  MediaShareContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol MediaShareView: BaseView {
    // TODO: Declare view methods
    //navigation bar
    func setupNavigationLeftItem(image named:String,title text:String)
    func setupNavigationRightItem(image named:String,title text:String)
    func setupNavigationTitle(with text:String)
    //table view
    func reloadTableList()
    //tool bar
    func setupToolBarLeftItem(image named:String,title text:String)
    func updateToolBar(title text:String)
    //warning badge
    func setupWarningBadge()
    func showWarningBadge(with text:String)
    func hideWarningBadge(with text:String)
}

protocol MediaSharePresentation: BasePresentation {
    // TODO: Declare presentation methods
    func cellInfo(forRowAt indexPath:IndexPath) -> (iconName:String,title:String)
    func numberOfRows(in section:Int) -> Int
    func numberOfSections() -> Int
    func didSelect(at indexPath:IndexPath)
    func titleForHeader(in section:Int) -> String
    func showDMRList()
    func dismissMediaShare()
    func fetchCurrentDevice()
}

protocol MediaShareUseCase: class {
    // TODO: Declare use case methods
    func checkNetworkStatus() throws
    func fetchTableList()
    func fetchCurrentDMR()
}

protocol MediaShareInteractorOutput: class {
    // TODO: Declare interactor output methods
    func tableListFetched(_ list:[IndexPath:MediaShareTypeProtocol])
    func currentDMRFetched(_ device:DMR?)
    func wifiConnectedError(_ error:MediaShareError)
    func wifiReconnectedSuccess()
}

protocol MediaShareWireframe: class {
    // TODO: Declare wireframe methods
    func dismissMediaShare()
    func pushPhotos()
    func pushMusic()
    func presentDMRList()
}

protocol MediaShareTypeProtocol {
    
    func getTitle() -> String
    func getImageName() -> String
}

protocol MediaShareError:Error {}
