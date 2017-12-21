//
//  BaseTabBarViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class BaseTabBarViewController: UITabBarController, StoryboardLoadable {

    // MARK: Properties

    var presenter: BaseTabBarPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.presentTabs()
    }
}

extension BaseTabBarViewController: BaseTabBarView {
    // TODO: implement view output methods
    
}
