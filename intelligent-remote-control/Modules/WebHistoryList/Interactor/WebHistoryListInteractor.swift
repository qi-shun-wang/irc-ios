//
//  WebHistoryListInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/14.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

///WebHistoryListInteractor contains the business logic as specified by a use case.
class WebHistoryListInteractor:WebHistoryListInteratorInputProtocol {
    
    
    var presenter: WebHistoryListInteratorOutputProtocol?
    
    var localDataManager: WebHistoryListLocalDataManagerInputProtocol?
    
    func retrieveHistoryList() {
        do{
            
            let websites = try localDataManager?.retrieveWebsites()
            print(websites ?? [])
            let current = Date()
            var section = 0
            
            var websiteModels:[Int:[WebsiteModel]] = [:]
            
            
            (websites ?? []).forEach(){
                    if $0.date.isBefore(date: current, granularity: .day) {
                        section += 1
                        compute(data: &websiteModels, target: section, source: $0)
                        return
                    }
                    compute(data: &websiteModels, target: section, source: $0)
                    
            }
            presenter?.didReceiveHistory(websiteModels)
            
        }catch{
            presenter?.didReceiveHistory([:])
        }
        
    }
    
    
    private func compute( data:inout [Int:[WebsiteModel]],target section:Int,source:Website){
        
        if data.keys.contains(section) {
            data[section]!.append(WebsiteModel(title:"\(source.title)",date:source.date,url:source.url))
            return
        }
        data[section] = [WebsiteModel(title:"\(source.title)",date:source.date,url:source.url)]
        
    }
}
