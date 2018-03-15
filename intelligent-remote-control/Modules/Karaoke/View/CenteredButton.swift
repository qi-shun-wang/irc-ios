//
//  CenteredButton.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/15.
//  Copyright © 2018年 ising99. All rights reserved.
//

import SnapKit
 @IBDesignable
class CenteredButton: UIButton {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
//        if titleLabel != nil && imageView != nil {
//            titleLabel!.snp.makeConstraints({ (make) in
//                make.bottom.equalToSuperview()
//                make.left.equalToSuperview()
//                make.right.equalToSuperview()
//                make.height.equalToSuperview().dividedBy(5)
//            })
//
//            imageView!.snp.makeConstraints({ (make) in
//                make.top.equalToSuperview()
//                make.left.equalToSuperview()
//                make.right.equalToSuperview()
//                make.bottom.equalTo(titleLabel!.snp.top)
//            })
//            imageView?.contentMode = .scaleAspectFit
//        }


    }
  
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if let imageView = self.imageView {
//            imageView.frame.origin.x = (self.bounds.size.width - imageView.frame.size.width) / 2.0
//            imageView.frame.origin.y = 0.0
//        }
//        if let titleLabel = self.titleLabel {
//            titleLabel.frame.origin.x = (self.bounds.size.width - titleLabel.frame.size.width) / 2.0
//            titleLabel.frame.origin.y = self.bounds.size.height - titleLabel.frame.size.height
//        }
//    }
}
