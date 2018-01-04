//
//  MediaSharePhotosContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol MediaSharePhotosView: BaseView {
    // TODO: Declare view methods
    
    //segment control
    func setupSegment()
    //collection view
    func setupPhotosCollectionView(tag: Int)
    func setupVideosCollectionView(tag: Int)
    func showPhotosCollectionView()
    func showVideosCollectionView()
    func setupNavigationToolBarLeftItem(image named: String, title text: String)
}

protocol MediaSharePhotosPresentation: BasePresentation {
    // TODO: Declare presentation methods
    func switchOnSegment(at index:Int)
    func showDMRList()
}

protocol MediaSharePhotosUseCase: class {
    // TODO: Declare use case methods
}

protocol MediaSharePhotosInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol MediaSharePhotosWireframe: class {
    // TODO: Declare wireframe methods
    func presentDMRList()
}
