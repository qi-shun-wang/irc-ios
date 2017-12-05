//
//  BaseViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class BaseViewModel: ViewModel {
    
    weak var view: BaseViewControllerProtocol?
    lazy var title:String = ""
    
    init(view: BaseViewControllerProtocol) {
        self.view = view
    }
    
    func openMenu() {
        view?.openMenu()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationTitle()
//        setupNavigationBarBackground()
        setupNavigationLeftItemIcon()
        setupViewBackgroundColor()
    }
    func setupNavigationTitle(){
        view?.renderNavigationTitle(with: title)
    }
    
//    func setupNavigationBarBackground(){
//        view?.renderNavigationBarBackgroundImage(named: "navi_bg")
//    }
    
    func setupNavigationLeftItemIcon(){
        view?.renderNavigationItemIcon(named: "radio_icon")
    }
    
    func setupRotatedNavigationBarBackground(){
        view?.rotatedNavigationBarBackgroundImage()
    }
    
    func setupRotatingNavigationBarBackground(){
        view?.rotatingNavigationBarBackgroundImage()
    }

    func setupViewBackgroundColor() {
        view?.setupViewBackgroundColor(named: "main_background_color")
    }
}
