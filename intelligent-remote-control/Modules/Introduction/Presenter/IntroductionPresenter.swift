//
//  IntroductionPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class IntroductionPresenter {

    // MARK: Properties
    private var models:[IntroModel] = [
        IntroModel(imageName: "menu", introDescription: "A"),
        IntroModel(imageName: "past", introDescription: "B"),
        IntroModel(imageName: "mouse", introDescription: "C")
    ]
    var currentPage:Int = 0 {
        
        didSet {
            let model =  models[currentPage]
            view?.render(currentPage)
            view?.render(with:model.introDescription, model.imageName)
            if currentPage == models.count - 1 {
                view?.showExit()
            }else {
                view?.hideExit()
            }
        }
    }
    
    weak var view: IntroductionView?
    var router: IntroductionWireframe?
    var interactor: IntroductionUseCase?
}

extension IntroductionPresenter: IntroductionPresentation {
    // TODO: implement presentation methods
    func viewDidLoad() {
        let first = models[0]
        view?.hideExit()
        view?.render(currentPage)
        view?.render(with:first.introDescription, first.imageName)
    }
    
    func exit() {
        router?.changeMainController()
    }
    
    func swipeRight() {
        print("swipe right")
        guard  currentPage > 0 else {return}
        currentPage -= 1
    }
    
    func swipeLeft() {
        print("swipe left")
        guard  currentPage < models.count - 1 else {return}
        currentPage += 1
    }
}

extension IntroductionPresenter: IntroductionInteractorOutput {
    // TODO: implement interactor output methods
}
