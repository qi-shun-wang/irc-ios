//
//  KaraokeTypeControlPanel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import SnapKit

class KaraokeTypeControlPanel: UIView {
    
    private let nibIdentifier:String = "KaraokeTypeControlPanel"
    let unselectedImage:UIImage? = UIImage(named:"karaoke_type_unselected_icon")
    let selectedImage:UIImage? = UIImage(named:"karaoke_type_selected_icon")
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var collection: [UIButton]!
    @IBAction func handleAction(_ sender:UIButton) {
        for button in collection {
            button.setBackgroundImage(unselectedImage, for: .normal)
        }
        sender.setBackgroundImage(selectedImage, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    
    /**
     Common initialization of view. Creates UIButton instances for base and handle.
     */
    private func initialize(){
        Bundle.main.loadNibNamed(nibIdentifier, owner: self, options: nil)
        addSubview(contentView)
        backgroundColor = UIColor(white: 0, alpha: 0)
        isOpaque = false
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        for button in collection {
            button.setTitleColor(.black, for: .normal)
            button.setTitle(KaraokeType(rawValue: button.tag)!.name, for: .normal)
            button.setBackgroundImage(UIImage(named:"karaoke_type_unselected_icon"), for: .normal)
        }
        
    }
    
    
}

enum KaraokeType:Int {
    case male = 1
    case female = 2
    case group = 3
    case male2male = 4
    case male2female = 5
    case female2female = 6
    
    var name:String {
        switch self {
        case .male:return "男歌星"
        case .female:return "女歌星"
        case .group:return "團體"
        case .male2male:return "男/男"
        case .male2female:return "男/女"
        case .female2female:return "女/女"
        }
    }
}
