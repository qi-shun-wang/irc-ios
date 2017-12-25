//
//  IntroductionInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class IntroductionInteractor {

    // MARK: Properties

    weak var output: IntroductionInteractorOutput?
    deinit {
        print("deinit---->\(self)")
    }
}

extension IntroductionInteractor: IntroductionUseCase {
    // TODO: Implement use case methods
}
