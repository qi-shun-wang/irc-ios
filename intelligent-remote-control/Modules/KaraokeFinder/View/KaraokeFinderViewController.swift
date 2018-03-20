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

    var presenter: KaraokeFinderPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension KaraokeFinderViewController: KaraokeFinderView {
    // TODO: implement view output methods
}
