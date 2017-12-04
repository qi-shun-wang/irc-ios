//
//  MenuHeaderView.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class MenuHeaderView: UIView {
    
    @IBOutlet weak var headerTitle: UILabel!
    fileprivate let smallLogoWidthPercentage:CGFloat = 0.25
    fileprivate let bigLogoWidthPercentage:CGFloat = 0.8
    
    @IBOutlet var component: UIView!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var profile: UIButton!
    @IBAction func openProfile(_ sender: UIButton) {
    }
    
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
        component.frame = bounds
        component.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        frame = bounds
        addSubview(component)
        let headerSize = CGSize(width: frame.width, height: frame.height*(1-bigLogoWidthPercentage)/2)
        let headerFrame =  CGRect(origin: CGPoint.zero, size: headerSize)
        headerTitle.frame = headerFrame
        headerTitle.text = "搜索KOD設備"
    }
    
}
extension MenuHeaderView: MenuHeaderViewProtocol {
    
    func setup() {
        viewModel?.bindingData()
    }
//    func render(with userID: String) {
//        titleName.layer.cornerRadius = 5
//        titleName.layer.borderWidth = 1
//        titleName.layer.borderColor = UIColor.white.cgColor
//        titleName.text = userID
//    }
    func renderBigLogo(named: String) {
        
        
        let bigLogoSize = CGSize(width: frame.width*bigLogoWidthPercentage, height: frame.height*bigLogoWidthPercentage)
        let bigLogoFrame = CGRect(origin: CGPoint.zero, size: bigLogoSize)
        logo.frame = bigLogoFrame
        logo.center = center
        
        userAvatar.isHidden = true
        profile.isHidden = true

    }
//    func renderSmallLogo(named: String) {
//
//        let smallLogoSize = CGSize(width: frame.width*smallLogoWidthPercentage, height: frame.height*smallLogoWidthPercentage)
//        let smallLogoOrigin = CGPoint(x: 8, y: 4 - statusBarHeight())
//        let smallLogoFrame = CGRect(origin: smallLogoOrigin, size: smallLogoSize)
//        logo.frame = smallLogoFrame
//        userAvatar.isHidden = false
//        profile.isHidden = false
//
//    }
    
}
