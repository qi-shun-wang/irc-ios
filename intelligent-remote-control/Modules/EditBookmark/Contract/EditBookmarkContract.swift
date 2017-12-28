//
//  EditBookmarkContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/26.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

protocol EditBookmarkView: BaseView {
    // TODO: Declare view methods
    func shrinkingTable(with deletePaths:[IndexPath],_ insertPaths:[IndexPath])
    func expandingTable(with deletePaths:[IndexPath],_ insertPaths:[IndexPath])
    func dismissKeyboard()
    func setupNavigationTitle(with text:String)
}

protocol EditBookmarkPresentation: BasePresentation {
    // TODO: Declare presentation methods
    func shrinkingTable()
    func expandingTable()
    func titleForHeader(in section:Int) -> String?
    func heightForHeader(in section:Int) -> Float
    func heightForRooter(in section:Int) -> Float
    func numberOfRows(in section:Int) -> Int
    func numberOfSections() -> Int
    func cellInfoForRow(at indexPath:IndexPath) -> (identifier:String,text:String,icon:String,indentationLevel:Int,indentationWidth:Float)
    func didSelect(at indexPath:IndexPath)
    func setupCurentFolder(at index:Int)
}

protocol EditBookmarkUseCase: class {
    // TODO: Declare use case methods
}

protocol EditBookmarkInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol EditBookmarkWireframe: class {
    // TODO: Declare wireframe methods
}
