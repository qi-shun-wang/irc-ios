//
//  KaraokeBookmarkPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class KaraokeBookmarkPresenter {
    
    // MARK: Properties
    
    weak var view: KaraokeBookmarkView?
    var router: KaraokeBookmarkWireframe?
    var interactor: KaraokeBookmarkUseCase?
}

extension KaraokeBookmarkPresenter: KaraokeBookmarkPresentation {
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupNavigationLeftItem(image: "navigation_back_white_icon", title: "")
    }
    
    func navigateBack() {
        router?.navigateBack()
    }
}

extension KaraokeBookmarkPresenter: KaraokeBookmarkInteractorOutput {
    // TODO: implement interactor output methods
}
