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
        devices = []
        view?.showToolbarLoadingItem()
        interactor?.startDiscoveringDMR()
    }
    
    func cellInfoForRows(at indexPath: IndexPath) -> (deviceName: String, deviceIcon: String) {
        let device = devices[indexPath.row]
        if indexPath.row == 0 {
            return (device.name,"device_local_icon")
        }
        return (device.name + ":" + device.ip,"device_remote_icon")
    }
    
    func numberOfRows(in section: Int) -> Int {
        return devices.count
    }
    
    func dismissMediaShareDMRListView() {
        interactor?.stopDiscoveringDMR()
        router?.dismissMediaShareDMRListView()
    }
    
    func viewDidLoad() {
        view?.setupToolBarTitle(with: "正在搜尋設備中...")
        view?.setupToolBarRightItem(image: "media_share_refresh_icon")
        view?.showToolbarLoadingItem()
        view?.setupToolBar()
        interactor?.startDiscoveringDMR()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        //ignore local device selected
        guard indexPath.row != 0 else {
            router?.dismissMediaShareDMRListView()
            return
        }
        interactor?.chooseDevice(at: indexPath.row)
    }
}

extension MediaShareDMRListPresenter: MediaShareDMRListInteractorOutput {
    
    func fetched(_ devices: [DMR]) {
        self.devices = devices
    }
    
    func didChoosedDevice(_ device: DMR) {
        interactor?.stopDiscoveringDMR()
        router?.dismissMediaShareDMRListView()
    }
    
    func stopDiscoveringDMR() {
        view?.hideToolbarLoadingItem()
        view?.setupToolBarTitle(with: "已找到的設備 ")
    }
}

