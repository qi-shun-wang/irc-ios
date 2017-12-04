//
//  MenuCellViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MenuCellViewModel: NSObject {
    
    weak var item: MenuItem?
    weak var view: MenuCellViewProtocol?
    
    init(model: MenuItem) {
        self.item = model
    }
    
    
    func prepare(_ view: MenuCellViewProtocol){
        self.view = view
    }
    
    func bindingData(){
        guard let cell = view else {
            print("You must prepare the view before binding data.")
            return
        }
        guard let item = item else {
            print("You must inject model before binding data or your model get lose.")
            return
        }
        cell.renderIcon(named: item.itemIcon)
        cell.renderTitle(with: item.itemTitle)
        cell.renderSubtitle(with: "192.168.1.25")
        if item.isConnected {
            cell.renderStatusTitle(with: "已連線")
        }else {
            cell.renderStatusTitle(with: "等待連線")
        }
        /* tempary not be used, may be needed in the future
         if item.isLastItem {
         cell.renderLowerLine(isHidden: false)
         }else{
         cell.renderLowerLine(isHidden: true)
         }
         
         
         */
        
    }
}


