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
    @IBOutlet weak var toolBar: UIToolbar!
    var toolBarTitle:UIBarButtonItem!
    var badge: WarningBadge = WarningBadge()
    var presenter: MediaSharePresentation?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
        presenter?.fetchCurrentDevice()
    }
    
    @objc func dismissMediaShare(){
        presenter?.dismissMediaShare()
    }
    
    @objc func openSetting(){
        
    }
    
    @objc func performCast() {
        presenter?.showDMRList()
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
    
    
    func setupToolBarLeftItem(image named: String, title text: String) {
        
        let left = UIBarButtonItem(image: UIImage(named:named)?.withRenderingMode(.alwaysOriginal),
                                   style: .plain,
                                   target: self,
                                   action: #selector(performCast))
        toolBarTitle = UIBarButtonItem(title: text, style: .plain, target: nil, action: nil)
        toolBarTitle.tintColor = .red
        let right = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.items = [left,toolBarTitle,right]
    }
    
    func updateToolBar(title text: String) {
        toolBarTitle.title = text
    }
    
    func setupWarningBadge() {
        let toViewFrame = CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 40)
        badge.frame = toViewFrame
        view.addSubview(badge)
    }
    
    func hideWarningBadge(with text: String) {
        badge.text = text
        let nvBarH = navigationController?.navigationBar.frame.height ?? 0
        let options = UIViewAnimationOptions.curveEaseIn
        let finalCenter = CGPoint(x:  UIScreen.main.bounds.width / 2, y: nvBarH + badge.frame.height)
        
        UIView.animate(withDuration: 1, delay: 0, options: options, animations: {
            self.badge.backgroundColor = .green
            self.badge.warningText.textColor = .black
        }) { (finished) in
            UIView.animate(withDuration: 5,delay: 1, animations: {
                self.badge.center = CGPoint(x: finalCenter.x, y:finalCenter.y - 100)
            })
        }
    }
    
    func showWarningBadge(with text: String) {
        badge.text = text
        let nvBarH = navigationController?.navigationBar.frame.height ?? 0
        let options = UIViewAnimationOptions.curveEaseIn
        let finalCenter = CGPoint(x:  UIScreen.main.bounds.width / 2, y: nvBarH + badge.frame.height )
        badge.center.y = (nvBarH + badge.frame.height) / 2
        UIView.animate(withDuration: 1, delay: 0, options: options, animations: {
            self.badge.backgroundColor = .red
            self.badge.warningText.textColor = .white
            self.badge.center = finalCenter
        }) { (finished) in
            self.badge.center = finalCenter
        }
        
    }
}
