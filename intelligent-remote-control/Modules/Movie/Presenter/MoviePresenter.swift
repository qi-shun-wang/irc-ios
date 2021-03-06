//
//  MoviePresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MoviePresenter {

    // MARK: Properties

    weak var view: MovieView?
    var router: MovieWireframe?
    var interactor: MovieUseCase?
}

extension MoviePresenter: MoviePresentation {
    
    func viewWillAppear() {
        
    }
    
    func viewWillDisappear() {
        
    }
    
    func viewDidLoad() {
        
    }
    
    
}

extension MoviePresenter: MovieInteractorOutput {
    // TODO: implement interactor output methods
}
