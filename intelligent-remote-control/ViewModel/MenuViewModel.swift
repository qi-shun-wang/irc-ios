//
//  MenuViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MenuViewModel: NSObject {
    
    weak var appState: AppState?
    weak var view: MenuViewControllerProtocol?
    var observer: ObserveMenuAbility?
    
    private var items:[MenuItem] = [
        
        MenuItem(named: "KOD iSing99-00", "radio_icon",isConnected:true),
        MenuItem(named: "KOD iSing99-01", "radio_icon",isConnected:false),
//        MenuItem(named: "遙控器", "menu_remote_icon", isMainEntry: true, at: Storyboard.irc),
//        MenuItem(named: "定調助手", "menu_tone_icon", at: Storyboard.tone),
//        MenuItem(named: "媒體分享", "menu_media_icon", at: Storyboard.mediaShare),
//        MenuItem(named: "操作使用提示", "menu_tip_icon", at: Storyboard.tips),
//        MenuItem(named: "雲端硬碟", "menu_cloud_icon", at: Storyboard.cloudDrive),
//        MenuItem(named: "設定", "menu_setting_icon", isLast: true, at: Storyboard.setting)
    ]
    private var user: UserModel?
    
    init(view: MenuViewControllerProtocol, state: AppState = AppState.shared) {
        self.view = view
        appState = state
    }

    func updateHeaderView() {
//        let path = Bundle.main.path(forResource: "AppState", ofType: "plist")
//        appState?.load(filePath: path)

        view?.renderMenuHeaderView()

    }
    
    var menuHeaderViewModel:MenuHeaderViewModel? {
        get {
//            guard let isSignIn = appState?.stateMap["isSignIn"] as? Bool else {
//                print("app state: isSignIn does not setup in AppState.plist")
//                return nil
//
//            }
//            //if user have been signed in
//            if isSignIn {
//                user = UserModel(userName: "shun", userID: "  ID:" + "00700" + "\t")
//                return MenuHeaderViewModel(model: user!)
//            }else{
//                //if user doesn't signed in
                return MenuHeaderViewModel()
//            }
        }
    }
    
    func numberOfRowsInSection(_ section:Int) -> Int {
        return items.count
    }
    
    func cellViewModel(_ indexPath:IndexPath)-> MenuCellViewModel? {
        return MenuCellViewModel(model: items[indexPath.row])
    }
    
    func didSelectRowAt(_ indexPath:IndexPath) -> MenuItem {
        let item = items[indexPath.row]
        print(item.itemTitle)
        return item
    }
    
//    func renderFirstSelectedCellBackground(){
//        view?.renderFirstSelectedCellBackground()
//    }
    
}
