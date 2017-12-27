//
//  EditBookmarkViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/26.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class EditBookmarkViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: EditBookmarkPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension EditBookmarkViewController: EditBookmarkView {
    // TODO: implement view output methods
}
