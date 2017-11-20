//
//  MenuCellViewProtocol.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

protocol MenuCellViewProtocol: TableViewCellProtocol {
    
    func renderTitle(with text: String)
    func renderIcon(named filename: String)
    //tempary not be used, may be needed in the future
    //func renderLowerLine(isHidden:Bool)
    func setup()
    
}
