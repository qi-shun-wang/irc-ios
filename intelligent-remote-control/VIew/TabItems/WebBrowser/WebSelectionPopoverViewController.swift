//
//  WebSelectionPopoverViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/13.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

protocol WebSelectionPopoverViewControllerDelegate: class {
    func didSelect(at webMenu:WebMenu)
}


struct WebMenu {
    let item:Selection
    
    var title:String {
        get {
            return item.rawValue
        }
    }
    internal enum Selection:String {
        case favorite = "我的收藏"
        case history = "歷史紀錄"
    }
}


class WebSelectionPopoverViewController: UIViewController {
    weak var delegate:WebSelectionPopoverViewControllerDelegate?
    var items = [ WebMenu(item: .favorite),
                  WebMenu(item: .history)
    ]
    
}

extension WebSelectionPopoverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
}

extension WebSelectionPopoverViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        dismiss(animated: true) {
            self.delegate?.didSelect(at:item)
        }
        
    }
}
