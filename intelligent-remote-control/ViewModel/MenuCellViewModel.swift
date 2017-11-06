//
//  MenuCellViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MenuCellViewModel: NSObject {
    
    weak var item:MenuItem?
    weak var view: MenuCellViewProtocol?
    
    init(model:MenuItem) {
        self.item = model
    }
    
    //call from view controller which has table view that prepare the cell
    func prepare(_ view:MenuCellViewProtocol){
        self.view = view
    }
    //call from menu cell which has a menu cell view model
    func bindingData(){
        guard
            let cell = view ,
            let item = item
            else {return}
        
        cell.setTitle(item.itemTitle)
    }
}


