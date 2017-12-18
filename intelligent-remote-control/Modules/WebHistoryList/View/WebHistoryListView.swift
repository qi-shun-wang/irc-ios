//
//  WebHistoryListView.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/14.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

///WebHistoryListView displays what it is told to by the Presenter and relays user input back to the Presenter.
class WebHistoryListView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: WebHistoryListPresenterProtocol?
    var websiteModels:[Int:[WebsiteModel]] = [:] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDiDLoad()
        
    }
    
    
    @objc func navigateBack(){
    
        navigationController?.popViewController(animated: true)
    
    }
    
    @objc func clearAllHistory(){
        
        presenter?.clearAllHistory()
        
    }
    
    
}

extension WebHistoryListView: WebHistoryListViewProtocol {
    
    
    func setupNavigationLeftItem(image named: String) {
        
        let button = UIButton()
        button.setImage(UIImage(named: named), for: .normal)
        button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
        button.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
    }
    
    func setupNavigationRightItem(with title: String) {
        
        let button = UIButton()
        button.sizeToFit()
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(clearAllHistory), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
    }
    
    func setupNavigationTitle(with text: String) {
        
        navigationItem.title = text
        
    }
    
    func hideLoading() {
        
    }
    
    func showLoading() {
        
    }
    
    func showError() {
        
    }
    
    func showHistoryList(with websites: [Int:[WebsiteModel]]) {
        websiteModels = websites
    }
    
    
}

extension WebHistoryListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebHistoryTableViewCell", for: indexPath) as! WebHistoryTableViewCell
        let model = websiteModels[indexPath.section]![indexPath.row]
        
        cell.set(model) {
            self.presenter?.deleteHistory(for: model)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websiteModels[section]!.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return websiteModels.keys.count
    }
}

extension WebHistoryListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFrame = CGRect(origin: CGPoint.zero, size: CGSize(width: tableView.bounds.width, height: 18))
        let header = UIView(frame: headerFrame)
        let titleFrame = CGRect(x: 10, y: 5, width: tableView.frame.size.width, height:  18)
        let title = UILabel(frame: titleFrame)
        title.font = UIFont.systemFont(ofSize: 14)
        title.textColor = .white
        title.text = "\(websiteModels[section]?.first?.date.inGMTRegion().string() ?? "")"
        header.addSubview(title)
        header.backgroundColor = UIColor(named: "main_background_color")
        
        return header
    }
    
}
