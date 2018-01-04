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
    }
}

extension MediaShareMusicViewController: MediaShareMusicView {
    // TODO: implement view output methods
}
