//
//  MenuCell.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    //tempary not be used, may be needed in the future
    /*
     fileprivate let lineWidthPercentage: CGFloat = 0.5
     */
    
    @IBOutlet weak var menuCellContainer: UIView!
    @IBOutlet weak var menuConnectionStatus: UILabel!
    @IBOutlet weak var menuSubtitle: UILabel!
    @IBOutlet weak var lowerline: UIView!
    @IBOutlet weak var upperline: UIView!
    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var menuIcon: UIImageView!
    weak var viewModel: MenuCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //tempary not be used, may be needed in the future
        /*
         let upperlineFrame = CGRect(x: 0, y: 0, width: frame.width*lineWidthPercentage, height: 1)
         upperline.frame = upperlineFrame
         let lowerlineFrame = CGRect(x: 0, y: frame.height-1, width: frame.width*lineWidthPercentage, height: 1)
         lowerline.frame = lowerlineFrame
         */
        upperline.isHidden = true
        lowerline.isHidden = true
//        menuCellContainer.layer.borderColor = UIColor.white.cgColor
//        menuCellContainer.layer.borderWidth = 1
        menuCellContainer.layer.cornerRadius = 10
    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        let selectedView = UIView()
//        selectedView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        selectedBackgroundView = selectedView
//    }
    
}

extension MenuCell: MenuCellViewProtocol {
    func setup() {
        guard let vm = viewModel else {print("MenuCellViewModel has not injected in MenuCell.Using MenuCellViewModel.bindingData() before have injected MenuCellViewModel into MenuCell.");return}
        vm.bindingData()
    }
    func renderTitle(with text: String) {
        menuTitle.text = text
    }
    func renderIcon(named filename: String) {
        menuIcon.image = UIImage(named:filename)
    }
    func renderStatusTitle(with text: String) {
        menuConnectionStatus.text = text
    }
    func renderSubtitle(with text: String) {
        menuSubtitle.text = text
    }
    
}
