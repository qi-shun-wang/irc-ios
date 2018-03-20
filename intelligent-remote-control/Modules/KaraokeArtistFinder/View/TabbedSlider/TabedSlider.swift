//
//  TabedSlider.swift
//  Slider
//
//  Created by Wang QiShun on 2016/12/14.
//  Copyright © 2016年 mtntech. All rights reserved.
//

import UIKit

public protocol TabbedSliderDelegate:class {
    func didChange(positionOf tab:Int)
}

@objc public protocol ItemInfo {
    var title: String { get set }
    var image: UIImage { get set }
    var color: UIColor { get set }
}
class Tab: ItemInfo {
    init(title:String) {
        self.title = title
    }
    @objc var title: String = ""
    @objc var image: UIImage = UIImage()
    @objc var color = UIColor.black
}

//@IBDesignable
public class TabbedSlider: UIView {
    
    
    
    //============== Initialization =============//
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    //========================================//
    
    
    
    
    
    //============== load view from nib ========//
    var view: UIView!
    
    
    // MARK: - Private functions
    
    
    private func loadXib() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        view.backgroundColor = UIColor.clear
        addSubview(view)
        
    }
    
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TabedSlider", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    //========================================//
    
    
    
    
  
    
    //============== reload tab ==============//
    @IBOutlet weak var tabsScrollView: UIScrollView!
   
    private var tabsInfo = [ItemInfo]()
    private var buttonTagOffset = 4827
    private var selectedTab = 0
    private var userInteracted = false
    private let marginWidth:CGFloat = 8
    
    private func reloadTabs() {
        let _ = tabsScrollView.subviews.map { $0.removeFromSuperview() }
        var i = 0
        var position_x:CGFloat = 0
        
        for item in tabsInfo {
            let stringWidth:CGFloat = CGFloat(Int((item.title as NSString).size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)]).width))
            let buttonWidth = stringWidth + 2 * marginWidth
            
            let button = TabButton(title: item.title, image: item.image,color: item.color)
            button.textSelected = textSelected
            button.textUnselected = textUnselected
            button.titleColor = textUnselected
            button.backgroundSelected = backgroundSelected
            button.backgroundUnselected = backgroundUnselected
            button.titleFont = UIFont.boldSystemFont(ofSize: 20)
            
            
            button.frame = CGRect(x: position_x, y: 0, width:buttonWidth, height: frame.height)
            button.tag = i + buttonTagOffset
            button.addTarget(self, action: #selector(TabbedSlider.selectedTab(_:)), for: .touchUpInside)
            if i == selectedTab {
                button.isSelected = true
            }
            tabsScrollView.addSubview(button)
            i += 1
            position_x += buttonWidth
        }
        tabsScrollView.contentSize = CGSize(width: position_x, height: frame.height)
    }
    //==========================================//
    
    
    //    private var contentWidth : Double {
    //        get {
    //
    //        }
    //    }
    
    
    
    
    //==============Target-Action ==============//
    @objc func selectedTab(_ sender: UIButton) {
        
        // Deselect previous tab
        if let previousSelected = tabsScrollView.viewWithTag(selectedTab + buttonTagOffset) as? UIButton {
            previousSelected.isSelected = false
        }
        
        
        // Select current tab
        sender.isSelected = true
        let currentSelectedTab = sender.tag - buttonTagOffset
        
        
        // Make sure that the current tab has been selected,such that doesn't delegate it again.
        guard  selectedTab != currentSelectedTab else {
            return
        }
        selectedTab = currentSelectedTab
        delegate?.didChange(positionOf: currentSelectedTab)//Delegate current tab to outer
        valueDidChange?(self, currentSelectedTab)
    }
    //===========================================//
    
    
    
    
    
    
    
    
    
    
    
    
    //=======customer properties =============//
    
    var delegate:TabbedSliderDelegate?
    
    var valueDidChange:TabedSliderSelectedCallback?
    
//    @IBInspectable
    var textSelected:UIColor = UIColor(red:0.9, green:0.36, blue:0.13, alpha:1.0) {
        didSet {
            reloadTabs()
        }
    }
//    @IBInspectable
    var textUnselected:UIColor = UIColor(white: 0.95, alpha: 1.0) {
        didSet {
            reloadTabs()
        }
    }
    
//    @IBInspectable
    var backgroundUnselected:UIColor = UIColor(white: 0.95, alpha: 1.0) {
        didSet {
            reloadTabs()
        }
    }
//    @IBInspectable
    var backgroundSelected:UIColor = UIColor(white: 0.95, alpha: 1.0) {
        didSet {
            reloadTabs()
        }
    }
    
    func createTabs(items: [ItemInfo]) {
        tabsInfo = items
        reloadTabs()
    }
    //=========================================//
}


typealias TabedSliderSelectedCallback = ((_ tabedSlider: TabbedSlider, _ selectedIndex: Int) -> Void)
