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
        
    }
    @objc func openSetting(){
        
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {
        
        let left = UIBarButtonItem(image: UIImage(named:named)?.withRenderingMode(.alwaysOriginal),
                                   style: .plain,
                                   target: self,
                                   action:  #selector(openSetting)
        )
        
        navigationItem.leftBarButtonItem = left
    }
    
    override func setupNavigationRightItem(image named: String, title text: String) {
        let button = UIButton()
        button.sizeToFit()
        button.setTitle(text, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(dismissMediaShare), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
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
    // TODO: implement view output methods
    
    func reloadTableList() {
        tableView.reloadData()
    }
    
    func setupNavigationTitle(with text: String) {
        navigationItem.title = text
    }
    
    func setupToolBarLeftItem(title: String) {
        
    }
    
    func setupNavigationToolBarLeftItem(image named: String, title text: String) {
        
        let left = UIBarButtonItem(image: UIImage(named:named)?.withRenderingMode(.alwaysOriginal),
                                   style: .plain,
                                   target: navigationController,
                                   action: #selector(MediaShareNavigationController.performCast))
        
        let right = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [left,right]
    }
    
    
}