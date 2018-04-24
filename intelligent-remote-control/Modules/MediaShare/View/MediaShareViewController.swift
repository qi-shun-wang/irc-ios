//
//  MediaShareViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MediaSharePresentation?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
    @objc func dismissMediaShare(){
        presenter?.dismissMediaShare()
    }
    
    @objc func openSetting(){
        
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {
        
        //        let left = UIBarButtonItem(image: UIImage(named:named)?.withRenderingMode(.alwaysOriginal),
        //                                   style: .plain,
        //                                   target: self,
        //                                   action:  #selector(openSetting)
        //        )
        //
        //        navigationItem.leftBarButtonItem = left
    }
    
    override func setupNavigationRightItem(image named: String, title text: String) {
        let close = UIBarButtonItem(title: text, style: .plain, target: self, action: #selector(dismissMediaShare))
        navigationItem.rightBarButtonItem = close
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    override func setupNavigationBarStyle() {
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
}

extension MediaShareViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInfo = presenter!.cellInfo(forRowAt: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaShareCell", for: indexPath)
        cell.imageView?.image = UIImage(named:cellInfo.iconName)
        cell.textLabel?.text = cellInfo.title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.numberOfRows(in: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter!.numberOfSections()
    }
    
}
extension MediaShareViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelect(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.titleForHeader(in: section)
    }
   
}

extension MediaShareViewController: MediaShareView {
    
    func reloadTableList() {
        tableView.reloadData()
    }
    
    func setupNavigationTitle(with text: String) {
        navigationItem.title = text
    }
    
}
