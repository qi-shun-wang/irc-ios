//
//  TipsViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/4/24.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class TipsViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: TipsPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TipsViewController: TipsView {
    // TODO: implement view output methods
}
