//
//  RootViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class RootViewModel:NSObject {
    lazy var path = Bundle.main.path(forResource: "AppState", ofType: "plist")
    
    weak var view:RootViewControllerProtocol?
    weak var appState:AppState?
    
    init(view:RootViewControllerProtocol) {
        self.view = view
    }
    
    func setupMainViewController(within storyboard:Storyboard) {
       
        appState = AppState.shared
        appState?.load(filePath: path)
        
        guard let isFirstLaunch = appState?.stateMap["isFirstLaunch"] as? Bool else{return}
        if isFirstLaunch {
            view?.setupMainViewController(within: Storyboard.intro)
            view?.setupRootGesture(isEnable: false)
            appState?.stateMap["isFirstLaunch"] = false
            
            appState?.update(filePath: path)
        }else {
            view?.setupMainViewController(within: storyboard)
            view?.setupRootGesture(isEnable: true)
        }
    }
    
    func setupLeftViewController(within storyboard:Storyboard){
        
        view?.setupLeftViewController(within: storyboard)
    }
    
}

