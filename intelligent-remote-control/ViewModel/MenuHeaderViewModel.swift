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
    
    convenience init(model: UserModel) {
        self.init()
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
            print("You can inject model before binding data or your model got lose.")
            //user is not login
            header.renderBigLogo(named: "ising99_logo")
            return
        }
        header.renderSmallLogo(named: "ising99_logo")
        header.render(with: user.userID)
        
    }
}

