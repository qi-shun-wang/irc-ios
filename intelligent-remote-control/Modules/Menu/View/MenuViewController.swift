//
//  MenuViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit
private let MenuCellIdentifier = "MenuCell"
class MenuViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties
    
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var menuListView: UITableView!
    
    fileprivate var items:[MenuItem] = [
        
        MenuItem(named: "KOD iSing99-00", "radio_icon",isConnected:true),
        MenuItem(named: "KOD iSing99-01", "radio_icon",isConnected:false),
        
    ]
    var presenter: MenuPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        
    }
    func renderMenuHeaderView() {
        
    }

    
}


extension MenuViewController :UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCellIdentifier, for: indexPath) as! MenuCell
        let item = items[indexPath.row]
        cell.menuTitle.text = item.itemTitle
        cell.menuIcon.image = UIImage(named:item.itemIcon)
        cell.menuSubtitle.text =  "192.168.1.25"
        
        if item.isConnected {
            cell.menuConnectionStatus.text = "已連線"
        }else {
            cell.menuConnectionStatus.text = "等待連線"
        }

        return cell
    }
    
}

extension MenuViewController :UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
}

extension MenuViewController: MenuView {
    // TODO: implement view output methods
}

