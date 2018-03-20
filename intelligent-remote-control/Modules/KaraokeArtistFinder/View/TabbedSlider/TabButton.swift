//
//  TabButton.swift
//  TabbedCollectionView
//
//  Created by Guilherme Moura on 12/1/15.
//  Copyright © 2015 Reefactor, Inc. All rights reserved.
//

import UIKit

class TabButton: UIButton {
    var backgroundUnselected = UIColor(white: 0.95, alpha: 1.0){
        didSet {
            backgroundColor = backgroundUnselected
        }
    }
    var backgroundSelected = UIColor(white: 0.95, alpha: 1.0){
        didSet {
            backgroundColor = backgroundSelected
        }
    }
    var textSelected = UIColor.orange
    var textUnselected = UIColor.white
    var titleColor = UIColor.darkGray{
        didSet {
            buildAttributedTitle()
        }
    }
    var titleFont = UIFont.systemFont(ofSize: 20) {
        didSet{
            buildAttributedTitle()
        }
    }
    private var title = ""
    private var image = UIImage()
    private var attributedTitle = NSAttributedString()
    
    init(title: String, image: UIImage, color: UIColor) {
        self.title = title
        self.image = image
        
        super.init(frame: CGRect.zero)
        
//        backgroundColor = backgroundUnselected
        
        buildAttributedTitle()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        backgroundColor = backgroundUnselected
        
        buildAttributedTitle()
    }
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue || isSelected {
                titleColor = textSelected
                backgroundColor = backgroundSelected
            } else {
                titleColor = textUnselected
                backgroundColor = backgroundUnselected
            }
            super.isHighlighted = newValue
        }
    }
    
    override var isSelected: Bool {
        get {
            return super.isSelected
        }
        set (isSelected){
            if isSelected {
                backgroundColor = backgroundSelected
                titleColor = textSelected
                
            } else {
                backgroundColor = backgroundUnselected
                titleColor = textUnselected
            }
            super.isSelected = isSelected
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        //        if selected {
        //
        //            let underscore = UIBezierPath()
        //            underscore.lineWidth = 3.0
        //            underscore.moveToPoint(CGPoint(x:rect.origin.x, y:rect.size.height))
        //            underscore.addLineToPoint(CGPoint(x:rect.size.width, y:rect.size.height))
        //            selectionColor.setStroke()
        //            underscore.stroke()
        //        }
        //
        //        let imageFrame = CGRect(x: rect.width/2.0 - 8.0, y: 3, width: 16, height: 16)
        //        self.tintColor.setFill()
        //        image.drawInRect(imageFrame)
        //
        let textFrame = CGRect(x: 4, y: rect.height / 2 - 8.0 , width: rect.width - 8, height: rect.height)
        attributedTitle.draw(in: textFrame)
    }
    
    func buildAttributedTitle() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let attributes: [NSAttributedStringKey: AnyObject] = [NSAttributedStringKey.foregroundColor: titleColor,
                                               NSAttributedStringKey.font:titleFont,
                                               NSAttributedStringKey.paragraphStyle: paragraphStyle]
        self.attributedTitle = NSAttributedString(string: title, attributes: attributes)
    }
}
