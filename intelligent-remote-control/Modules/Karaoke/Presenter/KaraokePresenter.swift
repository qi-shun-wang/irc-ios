//
//  KaraokePresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class KaraokePresenter {

    // MARK: Properties

    weak var view: KaraokeView?
    var router: KaraokeWireframe?
    var interactor: KaraokeUseCase?
}

extension KaraokePresenter: KaraokePresentation {
    // TODO: implement presentation methods
    func viewDidLoad(){
        
    }
}

extension KaraokePresenter: KaraokeInteractorOutput {
    // TODO: implement interactor output methods
}
