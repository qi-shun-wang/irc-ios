//
//  WebFavoriteViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/13.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class WebFavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    /*
        RootFolder---- FolderA (close)     <----|section 0
                    |                           |
                    -- FolderB (close)          |
                    |                      <----|
                    -- Blank
                    |                       <----|section 2
                    -- FileA                     |
                    |                            |
                    -- FileB|               <----|
        [[]]
     
     
     */
    var items:[[Content]] =
     
        [
            [
                WebsiteFolder(title: "FolderA", files: [], image: UIImage()),
                WebsiteFolder(title: "FolderB", files: [], image: UIImage())
            ],
            [
                WebsiteBlank()
            ],
            [
                WebsiteFile(image: UIImage(), url: "FileA"),
                WebsiteFile(image: UIImage(), url: "FileB")
            ]
     
        ] {
        
        didSet{
            tableView.reloadData()
        }
    }
    var contents: [[String]] = (0..<10).map { i in (0..<10).map { j in "\(i) - \(j)" } }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton()
        button.setImage(UIImage(named: "navigation_back_icon"), for: .normal)
        button.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
        button.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        let buttonR = UIButton()
        buttonR.sizeToFit()
        buttonR.setImage(UIImage(named: "navigation_folder_add_icon"), for: .normal)
        buttonR.addTarget(self, action: #selector(createFolder), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonR)
        
        
        navigationItem.title = "我的收藏"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    @objc func navigateBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func createFolder() {
        
    }
}

extension WebFavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
         return items[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        let item = items[indexPath.section][indexPath.row]
        cell.textLabel?.text = (item is Folder ? "Folder:\((item as! WebsiteFolder).title)" : (item is Blank ? "" : "File:\((item as! WebsiteFile).url)"))
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
   
}


extension WebFavoriteViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let item = items[indexPath.section][indexPath.row]
        return item is File ? true : false
    }
   
}
