//
//  MenuCellViewProtocol.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

protocol MenuCellViewProtocol: TableViewCellProtocol {
    
    func render(with text: String)
    func setup()
    
}
