//
//  IndentableTableViewCell.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/25.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class IndentableTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Update the separator
        separatorInset = UIEdgeInsets(top: 0, left: indentationWidth * CGFloat(indentationLevel) + 15, bottom: 0, right: 0)
        
        // Update the frame of the image view
        imageView!.frame = CGRect(
            x: imageView!.frame.origin.x + (CGFloat(indentationLevel) * indentationWidth),
            y: imageView!.frame.origin.y,
            width: imageView!.frame.size.width,
            height: imageView!.frame.size.height)
        
        // Update the frame of the text label
        textLabel!.frame = CGRect(
            x: imageView!.frame.origin.x  + 40,
            y: textLabel!.frame.origin.y ,
            width: frame.size.width - (imageView!.frame.origin.x + 60),
            height:textLabel!.frame.size.height)
        
        // Update the frame of the subtitle label
        //        self.detailTextLabel.frame = CGRectMake(self.imageView.frame.origin.x + 40, self.detailTextLabel.frame.origin.y, self.frame.size.width - (self.imageView.frame.origin.x + 60), self.detailTextLabel.frame.size.height);
    }
    
}
