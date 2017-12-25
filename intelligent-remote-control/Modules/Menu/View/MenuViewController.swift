//
//  MenuViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var menuListView: UITableView!
    
    var presenter: MenuPresentation!

    // MARK: Lifecycle

    override func viewDidLoad() {
        presenter.viewDidLoad()
    }
   
}


extension MenuViewController :UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = presenter.cellForRowAt(indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: data.identifier, for: indexPath) as! MenuCell
        //data binding
        cell.menuTitle.text = data.title
        cell.menuIcon.image = UIImage(named:data.icon)
        cell.menuSubtitle.text = data.subTitle
        cell.menuConnectionStatus.text = data.connectionStatus
        return cell
    }
    
}

extension MenuViewController :UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath)
        
    }
    
}

extension MenuViewController: MenuView {
    // TODO: implement view output methods
    func updateMenuTable() {
        menuListView.reloadData()
    }
}

