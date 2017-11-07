//
//  MenuHeaderView.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class MenuHeaderView: UIView {

    @IBOutlet var component: UIView!
    @IBOutlet weak var titleName: UILabel!
    
    weak var viewModel: MenuHeaderViewModel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed("MenuHeaderView", owner: self, options: nil)
        addSubview(component)
        component.frame = self.bounds
        component.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
    }
    
}
extension MenuHeaderView: MenuHeaderViewProtocol {
    
    func setup() {
        viewModel?.bindingData()
    }
    func render(with userID: String) {
        titleName.text = userID
    }
    
    
}
