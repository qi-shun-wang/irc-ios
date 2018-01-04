//
//  MediaShareDMRListPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MediaShareDMRListPresenter {
    
    // MARK: Properties
    
    weak var view: MediaShareDMRListView?
    var router: MediaShareDMRListWireframe?
    var interactor: MediaShareDMRListUseCase?
    
    fileprivate var devices:[DMR] = []{
        didSet{
            view?.reloadTable()
        }
    }
}

extension MediaShareDMRListPresenter: MediaShareDMRListPresentation {
    
    // TODO: implement presentation methods
    func refreshDMRList() {
        interactor?.startDiscoveringDMR()
    }
    
    func cellInfoForRows(at indexPath: IndexPath) -> (deviceName: String, deviceIcon: String) {
        let device = devices[indexPath.row]
        return (device.name,"")
    }
    
    func numberOfRows(in section: Int) -> Int {
        return devices.count
    }
    
    func dismissMediaShareDMRListView() {
        router?.dismissMediaShareDMRListView()
    }
    
    func viewDidLoad() {
        view?.setupToolBarTitle(with: "正在搜尋設備中...")
        view?.setupToolBarRightItem(image: "media_share_refresh_icon")
        view?.showToolbarLoadingItem()
        view?.setupToolBar()
    }
}

extension MediaShareDMRListPresenter: MediaShareDMRListInteractorOutput {
    // TODO: implement interactor output methods
    func fetched(_ devices: [DMR]) {
        self.devices = devices
    }
    
    func stopDiscoveringDMR() {
        view?.hideToolbarLoadingItem()
        view?.setupToolBarTitle(with: "已找到的設備 ")
    }
}
