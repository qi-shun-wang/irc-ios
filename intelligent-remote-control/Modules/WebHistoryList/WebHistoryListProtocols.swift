//
//  WebHistoryListProtocols.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/14.
//  Copyright © 2017年 ising99. All rights reserved.
//


import UIKit

struct WebsiteModel {
    let title:String
    let date:Date
    let url:String
}
class Website {
    let id:Int
    let title:String
    let url:String
    let date:Date
    init(id:Int,date:Date,title:String,url:String) {
        self.id = id
        self.date = date
        self.title = title
        self.url = url
    }
}


protocol WebHistoryListViewProtocol: class
{
    var presenter:WebHistoryListPresenterProtocol? {get set}
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

protocol WebHistoryListPresenterProtocol: class
{
    var view:WebHistoryListViewProtocol?{get set}
    var interactor:WebHistoryListInteratorInputProtocol?{get set}
    var router:WebHistoryListRoutingProtocol?{get set}
    ///preparing content for display
    func viewDiDLoad()
    ///reacting to user inputs 
    func clearAllHistory()
    func deleteHistory(for website:WebsiteModel)
    
}

protocol WebHistoryListRoutingProtocol: class
{
    static func createHistoryListModule() -> UIViewController
}

protocol WebHistoryListInteratorInputProtocol: class
{
    var presenter:WebHistoryListInteratorOutputProtocol?{get set}
    var localDataManager:WebHistoryListLocalDataManagerInputProtocol?{get set}
    
    func retrieveHistoryList()
    
}

protocol WebHistoryListInteratorOutputProtocol: class
{
    func didReceiveHistory(_ websites:[Int:[WebsiteModel]])
    func onError()
}


protocol WebHistoryListLocalDataManagerInputProtocol: class
{
    func retrieveWebsites() throws -> [Website]
    func saveWebsite(id:Int) throws
    
}


protocol WebHistoryListRemoteDataManagerInputProtocol: class
{
    
}


protocol WebHistoryListRemoteDataManagerOutputProtocol: class
{
    
}
