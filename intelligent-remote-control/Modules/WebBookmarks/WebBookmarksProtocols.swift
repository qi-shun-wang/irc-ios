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
    ///called presenter's viewDidLoad() will perform the setups below:
    func setupNavigationLeftItem(image named:String)
    func setupNavigationRightItem(with title:String)
    func setupNavigationTitle(with text:String)
    /// displays what it is told to by the Presenter and relays user input back to the Presenter.
    func hideLoading()
    func showLoading()
    func showError()
    func showHistoryList(with websites: [Int:[WebsiteModel]])
}

protocol WebBookmarksPresenterProtocol: class
{
    var view:WebBookmarksViewProtocol?{get set}
    var interactor:WebBookmarksInteratorInputProtocol?{get set}
    var router:WebBookmarksRoutingProtocol?{get set}
    ///preparing content for display
    func viewDiDLoad()
    ///reacting to user inputs
    func clearAllHistory()
    func deleteHistory(for website:WebsiteModel)
    
}

protocol WebBookmarksRoutingProtocol: class
{
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
