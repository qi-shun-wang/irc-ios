//
//  WebBookmarkViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class WebBookmarkViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    @IBOutlet weak var bookmarksTableView: UITableView!
    @IBOutlet weak var bookmarksSearchBar: UISearchBar!
    @IBOutlet weak var bookmarksSegment: UISegmentedControl!
    @IBOutlet weak var bookmarksEditBtn: UIBarButtonItem!
    @IBOutlet weak var newFolderBtn: UIBarButtonItem!
    @IBOutlet weak var historySearchBar: UISearchBar!
    @IBOutlet weak var historyTableView: UITableView!
    @IBAction func bookmarksIndexChanged(_ sender: UISegmentedControl) {
        presenter?.switchOnSegment(at: sender.selectedSegmentIndex)
    }
    @IBAction func pressOnRightBtn(_ sender: UIBarButtonItem) {
        presenter?.pressOnToolBarRightItem()
    }
    @objc func dismissBookmarks(){
        presenter?.dismiss()
    }
    
    var presenter: WebBookmarkPresentation?
    
    // MARK: Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        historyTableView.setContentOffset(CGPoint(x: 0, y: 90), animated: true)
    }
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    deinit {
        print("deinit---->\(self)")
    }
}

extension WebBookmarkViewController:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

extension WebBookmarkViewController:UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return presenter!.canMoveRow(about: tableView.tag ,at: indexPath)
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
}

extension WebBookmarkViewController:UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = presenter!.cellInfo(about: tableView.tag, cellForRowAt: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: info.id, for: indexPath)
        cell.showsReorderControl = true
        cell.imageView?.image = UIImage(named: info.iconName)
        cell.textLabel?.textColor = .white
        cell.textLabel?.text = info.title
        cell.accessoryType = info.isFolder ? .disclosureIndicator : .none
        cell.editingAccessoryType = info.isFolder ? .disclosureIndicator : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.numberOfRows(about: tableView.tag, in: section)
    }
    
}

extension WebBookmarkViewController: WebBookmarkView {
    
    // TODO: implement view output methods
    func setupNavigationLeftItem(image named: String) {
        
    }
    
    func setupNavigationRightItem(with title: String) {
        let button = UIButton()
        button.sizeToFit()
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(dismissBookmarks), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func setupNavigationTitle(with text: String) {
        navigationItem.title = text
    }
    
    func showNavigationBarLeftItem() {
        navigationItem.rightBarButtonItem?.isEnabled  = true
        navigationItem.rightBarButtonItem?.customView?.isHidden = false
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func hideNavigationBarLeftItem() {
        navigationItem.rightBarButtonItem?.isEnabled  = false
        navigationItem.rightBarButtonItem?.tintColor = .clear
        navigationItem.rightBarButtonItem?.customView?.isHidden = true
    }
    
    func disableBookmarksSegment() {
        bookmarksSegment.isEnabled = false
    }
    
    func enableBookmarksSegment() {
        bookmarksSegment.isEnabled = true
    }
    
    func setupSearchBarStyle() {
        historySearchBar.delegate = self
        bookmarksSearchBar.delegate = self
        historySearchBar.searchBarStyle = .minimal
        (historySearchBar.value(forKey: "searchField") as? UITextField)?.textColor = UIColor.white
        bookmarksSearchBar.searchBarStyle = .minimal
        (bookmarksSearchBar.value(forKey: "searchField") as? UITextField)?.textColor = UIColor.white
        
    }
    
    func showBookmarksTableView() {
        historyTableView.isHidden = true
        bookmarksTableView.isHidden = false
    }
    
    func showHistoryTableView() {
        historyTableView.isHidden = false
        bookmarksTableView.isHidden = true
    }
    
    func setupHistoryTableView(tag: Int) {
        historyTableView.tag = tag
        
    }
    
    func setupBookmarksTableView(tag: Int) {
        bookmarksTableView.tag = tag
    }
    
    func setupToolBarLeftItem(title: String) {
        newFolderBtn.title = title
    }
    
    func setupToolBarRightItem(title: String) {
        bookmarksEditBtn.title = title
    }
    
    func showToolBarLeftItem() {
        newFolderBtn.isEnabled = true
        newFolderBtn.tintColor = .white
        bookmarksTableView.setEditing(true, animated: true)
        bookmarksTableView.reloadData()
    }
    
    func hideToolBarLeftItem() {
        newFolderBtn.isEnabled = false
        newFolderBtn.tintColor = .clear
        bookmarksTableView.setEditing(false, animated: true)
    }
    func reloadHistoryTable() {
        historyTableView.reloadData()
    }
    func reloadBookmarkTable() {
        bookmarksTableView.reloadData()
    }
}
