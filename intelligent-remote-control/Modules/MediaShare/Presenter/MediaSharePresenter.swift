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
        if element == .localPhotos {
            router?.pushPhotos()
        }
        
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func viewDidLoad() {
        view?.setupNavigationTitle(with: "媒體分享")
        view?.setupToolBarLeftItem(image: "media_share_cast_icon", title: "")
        view?.setupNavigationLeftItem(image: "media_share_setting_icon", title: "")
        view?.setupNavigationRightItem(image: "", title: "關閉")
        interactor?.fetchTableList()
    }
    
    func showDMRList() {
        router?.presentDMRList()
    }
    
    func dismissMediaShare() {
        router?.dismissMediaShare()
    }
    
}

extension MediaSharePresenter: MediaShareInteractorOutput {
    
    // TODO: implement interactor output methods
    func tableListFetched(_ list: [IndexPath : MediaShareTypeProtocol]) {
        self.list = list
        view?.reloadTableList()
    }
   
}
