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
    weak var viewModel:MenuCellViewModel?
    
    func setup() {
        viewModel?.bindingData()
    }
}

extension MenuCell :MenuCellViewProtocol {
    func setTitle(_ text: String) {
        menuTitle.text = text
    }
}
