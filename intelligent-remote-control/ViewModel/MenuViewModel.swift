//
//  MenuViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MenuViewModel: NSObject {
    
    weak var appState:AppState?
    weak var view:MenuViewControllerProtocol?
    var observer:ObserveMenuAbility?
    
    private var items:[MenuItem] = [
        MenuItem(named:"遙控器",at:Storyboard.irc),
        MenuItem(named:"雲端硬碟",at:Storyboard.cloudDrive),
        MenuItem(named:"媒體分享",at:Storyboard.mediaShare),
        MenuItem(named:"定調助手",at:Storyboard.tone),
        MenuItem(named:"操作使用提示",at:Storyboard.tips),
        MenuItem(named:"設定",at:Storyboard.setting)
    ]
    
    
    init(view:MenuViewControllerProtocol,state:AppState = AppState.shared) {
        self.view = view
        appState = state
    }
    
    func setupHeaderView(){
        
    }
    
    func updateHeaderView()  {
         let path = Bundle.main.path(forResource: "AppState", ofType: "plist")
        appState?.load(filePath: path)
        
        guard
            let isSignIn = appState?.stateMap["isSignIn"] as? Bool
            else {
                print("app state: isSignIn does not setup in AppState.plist")
                return
                
        }
        
        //if user have been signed in
        if isSignIn {
            view?.setupUserHeaderView()
        }else{
            //if user doesn't signed in
            view?.setupPlainHeaderView()
        }
        
        
        
    }
    
    func numberOfRowsInSection(_ section:Int) -> Int {
        return items.count
    }
    
    func cellViewModel(_ indexPath:IndexPath)-> MenuCellViewModel? {
        return MenuCellViewModel(model: items[indexPath.row])
    }
    
    func didSelectRowAt(_ indexPath:IndexPath) -> MenuItem {
        return items[indexPath.row]
    }
}
