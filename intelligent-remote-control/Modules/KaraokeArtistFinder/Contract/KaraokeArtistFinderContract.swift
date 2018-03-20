//
//  KaraokeArtistFinderContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol KaraokeArtistFinderView: BaseView {
    func setupControlPanel()
}

protocol KaraokeArtistFinderPresentation: BasePresentation {
    func navigateBack()
    func cellForRow(at indexPath: IndexPath) -> String
    func numberOfRows(in section: Int) -> Int
    
}

protocol KaraokeArtistFinderUseCase: class {
    // TODO: Declare use case methods
}

protocol KaraokeArtistFinderInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol KaraokeArtistFinderWireframe: class {
    func navigateBack()
}
