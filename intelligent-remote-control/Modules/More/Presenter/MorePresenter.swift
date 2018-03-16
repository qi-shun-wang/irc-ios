//
//  MorePresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MorePresenter {

    // MARK: Properties
    var moreItems:[MoreModel] = [
        MoreModel(title:"雲端硬碟",iconFileName:"more_clouds_icon",type:MoreType.clouds),
        MoreModel(title:"媒體分享",iconFileName:"more_folder_icon",type:MoreType.mediaShare),
        MoreModel(title:"定調助手",iconFileName:"more_assistant_icon",type:MoreType.toneAssistant),
        MoreModel(title:"應用程式管理",iconFileName:"more_manager_icon",type:MoreType.appManager),
//        MoreModel(title:"按摩助手(iOS)",iconFileName:"more_exclamation_icon",type:MoreType.massageAssistant),
        
        ]
    
    weak var view: MoreView?
    var router: MoreWireframe?
    var interactor: MoreUseCase?
}

extension MorePresenter: MorePresentation {
    func didSelectItem(at indexPath: IndexPath) {
        guard indexPath.item > 0 else{return}
        let selectedType = moreItems[indexPath.item - 1].type
        if selectedType == .mediaShare {
            router?.presentMediaShare()
        }
    }
    
    func viewDidLoad() {
    }
    func numberOfItems() -> Int {
        return 1 + moreItems.count
    }
    
    func cellInfo(at indexPath:IndexPath) -> (icon: String, title: String) {
        guard indexPath.item > 0 else{return ("","")}
        return (moreItems[indexPath.item - 1].iconFileName,moreItems[indexPath.item - 1].title)
    }
    
}

extension MorePresenter: MoreInteractorOutput {
    // TODO: implement interactor output methods
}
