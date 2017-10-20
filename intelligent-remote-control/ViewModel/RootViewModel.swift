//
//  RootViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class RootViewModel:NSObject {
    
    weak var view:RootViewControllerProtocol?
    
    init(view:RootViewControllerProtocol) {
        self.view = view
    }
    
    func setupMainViewController(with identifier:String) {
        view?.setupMainViewController(with: identifier)
    }
    
    func setupLeftViewController(with identifier:String){
        view?.setupLeftViewController(with: identifier)
    }
    
    //    func setupRightViewController(with identifier:String){
    //        view?.setupRightViewController(with: identifier)
    //    }
}
