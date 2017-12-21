//
//  MovieViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MovieViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: MoviePresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MovieViewController: MovieView {
    // TODO: implement view output methods
}
