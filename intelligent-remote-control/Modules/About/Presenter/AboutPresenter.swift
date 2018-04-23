//
//  AboutPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/4/23.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class AboutPresenter {
    
    // MARK: Properties
    
    weak var view: AboutView?
    var router: AboutWireframe?
    var interactor: AboutUseCase?
    var data:[IndexPath:(String,String,Bool)] = [
    IndexPath(row: 0, section: 0):("目前版本號","1.0.0",false),
    IndexPath(row: 0, section: 1): ("隱私權政策","",true),
    IndexPath(row: 1, section: 1):("服務條款","",true)
    ]
}

extension AboutPresenter: AboutPresentation {
    
    func cellInfo(forRowAt indexPath: IndexPath) -> (title: String, subtitle: String, isDisclosure: Bool) {
        return data[indexPath]!
    }
  
    func numberOfRows(in section: Int) -> Int {
        let elements = data.keys.filter(){return $0.section == section}
        return elements.count
    }
    
    func numberOfSections() -> Int {
        return 2
    }
    
    func didSelect(at indexPath: IndexPath) {
        
    }
    
    func dismissAbout() {
        router?.dismissAbout()
    }
    
    func viewDidLoad() {
        view?.setupNavigationTitle(with: "關於")
        view?.setupNavigationRightItem(image: "", title: "關閉")
    }
    
    // TODO: implement presentation methods
}

extension AboutPresenter: AboutInteractorOutput {
    // TODO: implement interactor output methods
}
