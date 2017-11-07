//
//  MenuHeaderViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MenuHeaderViewModel: NSObject {
    
    weak var user: UserModel?
    
    var view: MenuHeaderViewProtocol?
    
   init(model: UserModel) {
        self.user = model
        
    }
    
    
    func prepare(_ view: MenuHeaderViewProtocol ){
        self.view = view
    }
    
    func bindingData(){
        
        guard let header = view else {
            print("You must prepare the view before binding data.")
            return
        }
        guard let user = user else {
            print("You must inject model before binding data or your model got lose.")
            return
        }
        
        header.render(with: user.userID)
        
    }
}

