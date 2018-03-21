//
//  KaraokeFinderViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class KaraokeFinderViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: KaraokeFinderPresentation?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    
    override func setupNavigationBarStyle() {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {
        let left = UIBarButtonItem(image: UIImage(named:named)?.withRenderingMode(.alwaysOriginal),
                                   style: .plain,
                                   target: self,
                                   action: #selector(backAction)
        )
        
        navigationItem.leftBarButtonItem = left
    }
    
    override func setupNavigationRightItem(image named: String, title text: String) {
        
    }
    
    @objc private func backAction(){
        presenter?.navigateBack()
    }
}

extension KaraokeFinderViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KaraokeCell", for: indexPath) as! KaraokeCell
        let info =  presenter!.cellForRow(at: indexPath, with: tableView.tag)
        cell.title.text = info.name
        cell.subtitle.text = info.artist
        cell.sign.isHidden = info.signHidden
        cell.sign2.isHidden = info.sign2Hidden
        cell.sign.text = info.signText
        cell.sign2.text = info.signText2
        cell.sign.backgroundColor = UIColor(named: info.signColor)
        cell.sign2.backgroundColor = UIColor(named: info.signColor2)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.numberOfRows(in:section,with:tableView.tag)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension KaraokeFinderViewController: KaraokeFinderView {
    
    func reloadKaraokes() {
        tableView.reloadData()
    }
    
    func setupTitle(text:String) {
        title = text
    }
}
