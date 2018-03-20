//
//  KaraokeBookmarkViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class KaraokeBookmarkViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: KaraokeBookmarkPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
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

extension KaraokeBookmarkViewController: KaraokeBookmarkView {
    // TODO: implement view output methods
}
