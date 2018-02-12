//
//  MediaShareDMRListViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

protocol MediaShareDMRListViewControllerDelegate: class {
    func didDismissMediaShareDMRListView()
}

class MediaShareDMRListViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    weak var delegate:MediaShareDMRListViewControllerDelegate?
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var titleItem: UILabel!
    @IBOutlet weak var rightItem: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var refreshImage: UIImageView!
    var presenter: MediaShareDMRListPresentation?
    
    // MARK: Lifecycle
    var transitioningBackgroundView : UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(dismissView))
        transitioningBackgroundView.isUserInteractionEnabled = true
        transitioningBackgroundView.addGestureRecognizer(gestureRecognizer)
        presenter?.viewDidLoad()
    }
    @objc func dismissView(){
        presenter?.dismissMediaShareDMRListView()
    }
    
    @IBAction func refreshDMR(_ sender: UIButton) {
        presenter?.refreshDMRList()
    }
    
}

extension MediaShareDMRListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInfo = presenter?.cellInfoForRows(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) 
        cell.imageView?.image = UIImage(named: cellInfo?.deviceIcon ?? "")
        cell.textLabel?.text = cellInfo?.deviceName
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.numberOfRows(in: section)
    }
    
}

extension MediaShareDMRListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath)
    }
    
}

extension MediaShareDMRListViewController: MediaShareDMRListView {
    
    // TODO: implement view output methods
    func dismissDMRList(){
        delegate?.didDismissMediaShareDMRListView()
    }
    func reloadTable() {
        tableView.reloadData()
    }
    
    func showToolbarLoadingItem() {
        rightItem.isEnabled = false
        refreshImage.isHidden = true
        loading.startAnimating()
    }
    func hideToolbarLoadingItem() {
        rightItem.isEnabled = true
        refreshImage.isHidden = false
        loading.stopAnimating()
    }
   
    func setupToolBar() {
    }
    
    func setupToolBarTitle(with text: String) {
        titleItem.text = text
    }
    func setupToolBarRightItem(image named: String) {
        refreshImage.image = UIImage(named:named)
    }
}
