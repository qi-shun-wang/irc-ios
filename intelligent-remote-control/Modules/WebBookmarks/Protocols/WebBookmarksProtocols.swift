//
//  WebBookmarksProtocols.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/18.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit


protocol WebBookmarksViewProtocol: class
{
    var presenter:WebBookmarksPresenterProtocol? {get set}
    /// displays what it is told to by the Presenter and relays user input back to the Presenter.
    
    //navigation bar
    func setupNavigationLeftItem(image named:String)
    func setupNavigationRightItem(with title:String)
    func setupNavigationTitle(with text:String)
    func showNavigationBarLeftItem()
    func hideNavigationBarLeftItem()
    //segmented control
    func disableBookmarksSegment()
    func enableBookmarksSegment()
    //search bar
    func setupSearchBarStyle()
    //table view
    func showBookmarksTableView()
    func showHistoryTableView()
    func setupHistoryTableView(tag:Int)
    func setupBookmarksTableView(tag:Int)
    //tool bar
    func setupToolBarLeftItem(title:String)
    func setupToolBarRightItem(title:String)
    func showToolBarLeftItem()
    func hideToolBarLeftItem()
    
    func hideLoading()
    func showLoading()
    func showError()
    
    
    
}

protocol WebBookmarksPresenterProtocol: class
{
    weak var view:WebBookmarksViewProtocol?{get set}
    var interactor:WebBookmarksInteratorInputProtocol?{get set}
    var router:WebBookmarksRoutingProtocol?{get set}
    
    ///preparing content for display
    func viewDiDLoad()
    ///reacting to user inputs
    func dismiss()
    
    var isEditing:Bool{get set}
    func pressOnToolBarRightItem()
    func pressOnToolBarLeftItem()
    func switchOnSegment(at index:Int)
    
    func cellInfo(about tableViewTag:Int,cellForRowAt indexPath:IndexPath) -> (id:String,iconName:String,title:String)
    func numberOfRows(about tableViewTag:Int,in section:Int) -> Int
    
}

protocol WebBookmarksRoutingProtocol: class
{
    weak var navigationView:UIViewController?{get set}
    func dismiss()
    static func createWebBookmarksModule() -> UIViewController
}

protocol WebBookmarksInteratorInputProtocol: class
{
    var presenter:WebBookmarksInteratorOutputProtocol?{get set}
    var localDataManager:WebBookmarksLocalDataManagerInputProtocol?{get set}
    
    func retrieveHistoryList()
    
}

protocol WebBookmarksInteratorOutputProtocol: class
{
    func didReceiveHistory(_ websites:[Int:[WebsiteModel]])
    func onError()
}


protocol WebBookmarksLocalDataManagerInputProtocol: class
{
    func retrieveWebsites() throws -> [Website]
    func saveWebsite(id:Int) throws
    
}


protocol WebBookmarksRemoteDataManagerInputProtocol: class
{
    
}


protocol WebBookmarksRemoteDataManagerOutputProtocol: class
{
    
}
