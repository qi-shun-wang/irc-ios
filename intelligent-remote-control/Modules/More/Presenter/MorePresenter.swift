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
    var moreItems:[MoreType] = [
        MoreType.account,
        MoreType.settings,
        MoreType.about,
        MoreType.tips,
        MoreType.clouds,
        MoreType.mediaShare,
        MoreType.toneAssistant,
        MoreType.appManager
        ]
    
    weak var view: MoreView?
    var router: MoreWireframe?
    var interactor: MoreUseCase?
}

extension MorePresenter: MorePresentation {
    func didSelectItem(at indexPath: IndexPath) {
//        guard indexPath.item > 0 else{return}
        let selectedType = moreItems[indexPath.item]
        
        switch selectedType {
        case .mediaShare:
            router?.presentMediaShare()
        case .about:
            router?.presentAbout()
        case .tips:
            router?.presentTips()
        default:
            break
        }
    }
    
    func viewDidLoad() {
    }
    func numberOfItems() -> Int {
        return moreItems.count
    }
    
    func cellInfo(at indexPath:IndexPath) -> (icon: String, title: String) {
//        guard indexPath.item > 0 else{return ("","")}
        return (moreItems[indexPath.item].getImageName(),moreItems[indexPath.item].getTitle())
    }
    
}

extension MorePresenter: MoreInteractorOutput {
    // TODO: implement interactor output methods
}
