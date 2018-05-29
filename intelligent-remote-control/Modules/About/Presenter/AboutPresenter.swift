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
    var data:[IndexPath:(title:String,String,Bool,Bool)] = [
        IndexPath(row: 0, section: 0):("目前版本號","1.0.0",false,false),
        IndexPath(row: 0, section: 1): ("隱私權政策","",true,true),
        IndexPath(row: 1, section: 1):("服務條款","",true,true)
    ]
}

extension AboutPresenter: AboutPresentation {
    
    func viewWillDisappear() {
        
    }
    
    func cellInfo(forRowAt indexPath: IndexPath) -> (title: String, subtitle: String, isDisclosure: Bool,isSelectable:Bool) {
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
        if indexPath.section > 0 {
            router?.presentWeb(url: "https://sim.ising99.com/commingsoon",with: data[indexPath]?.title ?? "")
        }
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
