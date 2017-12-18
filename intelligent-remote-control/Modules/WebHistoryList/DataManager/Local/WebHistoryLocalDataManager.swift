//
//  WebHistoryLocalDataManager.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/14.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import SwiftDate
class WebHistoryLocalDataManager: WebHistoryListLocalDataManagerInputProtocol {
    
    
    func retrieveWebsites() throws -> [Website] {
        
        return [
            Website(id:0,date:0.day.ago()!,title:"Google",url:"www.google.com"),
            Website(id:1,date:1.day.ago()!,title:"Apple",url:"www.apple.com"),
            Website(id:2,date:2.day.ago()!,title:"Laws in Taiwan",url:"www.normalbook.info")
            ].sorted(){$0.date > $1.date}
    }
    
    func saveWebsite(id: Int) throws {
        
    }
    
    
}
