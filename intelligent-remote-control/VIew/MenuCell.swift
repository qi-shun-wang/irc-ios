//
//  MenuCell.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var menuTitle: UILabel!
    weak var viewModel: MenuCellViewModel?
    
   
}

extension MenuCell: MenuCellViewProtocol {
    func render(with text: String) {
        menuTitle.text = text
    }
    func setup() {
        viewModel?.bindingData()
    }
}
