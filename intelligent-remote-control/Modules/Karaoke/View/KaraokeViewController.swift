//
//  KaraokeViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class KaraokeViewController: BaseViewController, StoryboardLoadable {
    
    @IBOutlet weak var tableView: UITableView!
    // MARK: Properties
  
    var presenter: KaraokePresentation?
    var shouldShowSearchResults = false
    var karaokeArray:[String] = ["K","B"]
    var searchedArray:[String] = ["A","C"]
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension KaraokeViewController: KaraokeView {
    // TODO: implement view output methods
    
    
}

extension KaraokeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension KaraokeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return searchedArray.count
        }else {
            return karaokeArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KaraokeCell", for: indexPath)
        if shouldShowSearchResults {
            cell.textLabel?.text = searchedArray[indexPath.row]
        }
        else {
            cell.textLabel?.text = karaokeArray[indexPath.row]
        }
        return cell
    }
}
