//
//  MediaShareMusicViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareMusicViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: MediaShareMusicPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    override func setupNavigationBarStyle() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {}
    
    override func setupNavigationRightItem(image named: String, title text: String) {}
}

extension MediaShareMusicViewController: MediaShareMusicView {
    // TODO: implement view output methods
}
