//
//  AboutViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/4/23.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var presenter: AboutPresentation?

    // MARK: Lifecycle
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
    @objc func dismissAbout(){
        presenter?.dismissAbout()
    }
    override func setupNavigationLeftItem(image named: String, title text: String) {
    }
    
    override func setupNavigationRightItem(image named: String, title text: String) {
        let button = UIButton()
        button.sizeToFit()
        button.setTitle(text, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(dismissAbout), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    override func setupNavigationBarStyle() {
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
}

extension AboutViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInfo = presenter!.cellInfo(forRowAt: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath) as!AboutCell
        cell.selectionStyle = cellInfo.isSelectable ? .default : .none
        cell.subtitle.text = cellInfo.subtitle
        cell.title.text = cellInfo.title
        cell.indicator.isHidden = cellInfo.isDisclosure ? false:true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter!.numberOfSections()
    }
    
}
extension AboutViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelect(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
}

extension AboutViewController: AboutView {
    
    func reloadTableList() {
        tableView.reloadData()
    }
    
    func setupNavigationTitle(with text: String) {
        navigationItem.title = text
    }
    
}
