//
//  KaraokeViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class KaraokeViewController: BaseViewController2, StoryboardLoadable {

    // MARK: Properties

    var presenter: KaraokePresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension KaraokeViewController: KaraokeView {
    // TODO: implement view output methods
}
