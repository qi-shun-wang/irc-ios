//
//  WebBookmarksViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/18.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

enum Bookmarks: Int {
    case favorite
    case history
}

class WebBookmarksViewController: UIViewController {
    
    @IBOutlet weak var bookmarksSegment: UISegmentedControl!
    fileprivate var items:[String] = []
    fileprivate var currentBookmark:Bookmarks = .favorite {
        didSet {
            switch currentBookmark {
            case .favorite:
                print("favorite")
            case .history:
                print("history")
            }
            
        }
    }
    
    @IBAction func bookmarksIndexChanged(_ sender: UISegmentedControl) {
        
        guard let bookmarks = Bookmarks(rawValue: sender.selectedSegmentIndex) else {
            print("Bookmarks not support segment index:\(sender.selectedSegmentIndex)")
            return
        }
        currentBookmark = bookmarks
        
    }
}


extension WebBookmarksViewController:UITableViewDelegate  {
    
}

extension WebBookmarksViewController:UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
