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

    weak var view: MoreView?
    var router: MoreWireframe?
    var interactor: MoreUseCase?
}

extension MorePresenter: MorePresentation {
    func viewDidLoad() {
        
    }
    
    // TODO: implement presentation methods
}

extension MorePresenter: MoreInteractorOutput {
    // TODO: implement interactor output methods
}
