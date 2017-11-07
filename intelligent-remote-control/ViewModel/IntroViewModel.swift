//
//  IntroViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/5.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class IntroViewModel: NSObject {
    
    private var models:[IntroModel] = [
        IntroModel(imageName: "menu", introDescription: "A"),
        IntroModel(imageName: "past", introDescription: "B"),
        IntroModel(imageName: "mouse", introDescription: "C")
    ]
    
    weak var view: IntroViewControllerProtocol?
    var currentPage:Int
    
    init(view:IntroViewControllerProtocol) {
        self.view = view
        self.currentPage = 0
        self.view?.hideExitButton()
    }
    
    func exit(to storyboard:Storyboard){
        view?.exit(to: storyboard)
    }
    func swipeLeft(){
        
        view?.swipeLeft()
        if currentPage == models.count - 1 {
            view?.showExitButton()
        }
    }
    
    func swipeRight(){
        view?.hideExitButton()
        view?.swipeRight()
        
    }
    
    func maximumPage() -> Int {
        return models.count
    }
    
    func update(page:Int) {
        currentPage = page
        let model = models[page]
        view?.render(with:model.introDescription,model.imageName)
        
    }
}

