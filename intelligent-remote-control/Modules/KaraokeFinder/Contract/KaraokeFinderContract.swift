//
//  KaraokeFinderContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol KaraokeFinderView: BaseView {
    // TODO: Declare view methods
}

protocol KaraokeFinderPresentation: BasePresentation {
    
    func numberOfRows(in section: Int, with tableViewTag: Int) -> Int
    func cellForRow(at indexPath: IndexPath, with tableViewTag: Int) -> (
        name: String,
        artist: String,
        signText: String,
        signText2: String,
        signColor: String,
        signColor2: String,
        signHidden: Bool,
        sign2Hidden: Bool)
    func navigateBack()
}

protocol KaraokeFinderUseCase: class {
    // TODO: Declare use case methods
}

protocol KaraokeFinderInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol KaraokeFinderWireframe: class {
    
    func navigateBack()
    
}
