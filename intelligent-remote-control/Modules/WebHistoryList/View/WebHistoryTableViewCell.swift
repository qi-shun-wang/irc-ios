//
//  WebHistoryTableViewCell.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/14.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class WebHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    @IBAction func deleteAction(_ sender: UIButton) {
        action?()
    }
    private var action:(() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(_ model:WebsiteModel,deleteAction:@escaping (() -> Void)) {
        title.text = model.title
        subtitle.text = model.url
        action = deleteAction
    }
}
