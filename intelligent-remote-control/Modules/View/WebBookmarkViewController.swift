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

    var presenter: WebBookmarkPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension WebBookmarkViewController: WebBookmarkView {
    // TODO: implement view output methods
}
