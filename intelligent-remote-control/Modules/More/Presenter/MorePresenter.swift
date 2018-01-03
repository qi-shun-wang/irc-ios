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
    var collections:[IndexPath:MoreTypeProtocol] = [
        IndexPath(item: 1, section: 0):MoreType.clouds,
        IndexPath(item: 2, section: 0):MoreType.mediaShare,
        IndexPath(item: 3, section: 0):MoreType.appManager,
        IndexPath(item: 4, section: 0):MoreType.toneAssistant,
        IndexPath(item: 5, section: 0):MoreType.massageAssistant
    ]
    
    
    weak var view: MoreView?
    var router: MoreWireframe?
    var interactor: MoreUseCase?
}

extension MorePresenter: MorePresentation {
    func didSelectItem(at indexPath: IndexPath) {
        guard let element = collections[indexPath] as? MoreType else {return}
        if element == .mediaShare {
            router?.presentMediaShare()
        }
    }
    
    func viewDidLoad() {
        
    }
    
    // TODO: implement presentation methods
}

extension MorePresenter: MoreInteractorOutput {
    // TODO: implement interactor output methods
}
