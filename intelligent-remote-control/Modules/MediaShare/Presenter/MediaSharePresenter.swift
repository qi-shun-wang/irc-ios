//
//  MediaSharePresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation


class MediaSharePresenter {
    
    // MARK: Properties
    
    weak var view: MediaShareView?
    var router: MediaShareWireframe?
    var interactor: MediaShareUseCase?
    var list:[IndexPath:MediaShareTypeProtocol] = [:]
}

extension MediaSharePresenter: MediaSharePresentation {
    
    // TODO: implement presentation methods
    func cellInfo(forRowAt indexPath: IndexPath) -> (iconName: String, title: String) {
        return
            (list[indexPath]?.getImageName() ?? "",list[indexPath]?.getTitle() ?? "")
    }
    
    func numberOfRows(in section: Int) -> Int {
        let elements = list.keys.filter(){return $0.section == section}
        return elements.count
    }
    func titleForHeader(in section: Int) -> String {
        if section == 0 {
            return "我的資源庫"
        }
        return "更多資源庫"
        
    }
    func didSelect(at indexPath: IndexPath) {
        guard let element = list[indexPath] as? MediaShareType else {return}
        switch element {
        case .localMusic:
             router?.pushMusic()
        case .localPhotos:
            router?.pushPhotos()
        default:break
        }
         
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func viewDidLoad() {
        view?.setupNavigationTitle(with: "媒體分享")
        view?.setupToolBarLeftItem(image: "media_share_cast_icon", title: "尚未連接設備")
        view?.setupNavigationLeftItem(image: "media_share_setting_icon", title: "")
        view?.setupNavigationRightItem(image: "", title: "關閉")
        view?.setupWarningBadge()
        do {
            try interactor?.checkNetworkStatus()
        } catch {
            view?.showWarningBadge(with: "尚未連接WiFi，請到設定>WiFi>開啟WiFi")
        }
        interactor?.fetchTableList()
    }
    
    func showDMRList() {
        router?.presentDMRList()
    }
    
    func dismissMediaShare() {
        router?.dismissMediaShare()
    }
    
    func fetchCurrentDevice() {
        interactor?.fetchCurrentDMR()
    }
}

extension MediaSharePresenter: MediaShareInteractorOutput {
    
    // TODO: implement interactor output methods
    func currentDMRFetched(_ device: DMR?) {
        let title = device != nil ? "已連接設備 \(device!.name)":"尚未連接設備"
        view?.updateToolBar(title: title)
    }
    
    func tableListFetched(_ list: [IndexPath : MediaShareTypeProtocol]) {
        self.list = list
        view?.reloadTableList()
    }
    
    func wifiConnectedError(_ error: MediaShareError) {
        view?.showWarningBadge(with: "尚未連接WiFi，請到設定>WiFi>開啟WiFi")
    }
    
    func wifiReconnectedSuccess() {
        view?.hideWarningBadge(with:"已經連上WiFi")
    }
    
}
