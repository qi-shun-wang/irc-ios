//
//  MediaShareDMRListContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol MediaShareDMRListView: BaseView {
    // TODO: Declare view methods
    func setupToolBar()
    func setupToolBarTitle(with text:String)
    func setupToolBarRightItem(image named:String)
    func showToolbarLoadingItem()
    func hideToolbarLoadingItem()
    func reloadTable()
    
}

protocol MediaShareDMRListPresentation: class {
    // TODO: Declare presentation methods
    func dismissMediaShareDMRListView()
    func refreshDMRList()
    func viewDidLoad()
    func numberOfRows(in section:Int) -> Int
    func cellInfoForRows(at indexPath:IndexPath) -> (deviceName:String,deviceIcon:String)
    func didSelectRow(at indexPath:IndexPath)
}

protocol MediaShareDMRListUseCase: class {
    // TODO: Declare use case methods
    func startDiscoveringDMR()
    func stopDiscoveringDMR()
    func chooseDevice(at index:Int)
}

protocol MediaShareDMRListInteractorOutput: class {
    // TODO: Declare interactor output methods
    func fetched(_ devices:[DMR])
    func stopDiscoveringDMR()
    func didChoosedDevice(_ device:DMR)
}

protocol MediaShareDMRListWireframe: class {
    // TODO: Declare wireframe methods
    func dismissMediaShareDMRListView()
}
