//
//  IRCModePopoverViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/5.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

protocol IRCModePopoverViewControllerDelegate: class {
    func didSelect(mode:IRCMode)
    
}

class IRCModePopoverViewController: UIViewController {
    
    weak var delegate:IRCModePopoverViewControllerDelegate?
    
    fileprivate var items:[IRCMode] = [
        IRCMode(type: .general),
        IRCMode(type: .normal),
        IRCMode(type: .touch),
        IRCMode(type: .mouse),
        IRCMode(type: .keyboard),
        IRCMode(type: .game),
        
    ]
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
}



extension IRCModePopoverViewController:UITableViewDelegate {
    
}
extension IRCModePopoverViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModeCell") ?? UITableViewCell()
        let item = items[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.imageView?.image = UIImage(named:item.iconFileName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        dismiss(animated: true) {
            self.delegate?.didSelect(mode: item)
        } 
        
    }
    
    
}
