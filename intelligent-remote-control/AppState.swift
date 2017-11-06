//
//  AppState.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/5.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
protocol ObserveMenuAbility {
    func didChanged()
    func willChanged()
}
protocol ObserveStateAbility {
    
    func willChanged(_ state:State)
    func didChanged(_ state:State)
}

protocol State {
    var observers:[String:ObserveStateAbility]{get set}
    var hasWatched:Bool {get set }
    mutating func watched()->State
    mutating func touched(identifier:String)->State
}
extension State {
    
    mutating func add(observer:ObserveStateAbility,with identifier:String){
        observers[identifier] = observer
    }
    
    mutating func remove(observer:ObserveStateAbility,identifier:String) {
        observers[identifier] = nil
    }
    mutating func touched(identifier:String)->State{
        
        observers[identifier]?.willChanged(self)
        hasWatched = false
        observers[identifier]?.didChanged(self)
        
        return self
    }
    
    mutating func watched()->State{
        hasWatched = true
        return self
    }
    
}



class AppState :State {
    
    private init(){}
    static let shared = AppState()
    var observers:[String:ObserveStateAbility] = [:]
    
    var hasWatched = false
    var stateMap:[String:Any] = [:] {
        didSet {
            
            print(stateMap)
        }
    }
    
    
    
    func load(filePath:String?) -> Void {
        
        guard
            let filePath = filePath,
            let dic = NSDictionary(contentsOfFile: filePath) as? [String:Any]
            else {return}
        stateMap = dic
        
        
    }
    func update(filePath:String?) -> Void {
        guard
            let filePath = filePath,
            var dic = NSDictionary(contentsOfFile: filePath)
            else {return}
        dic = NSDictionary(dictionary: stateMap)
        dic.write(toFile: filePath, atomically: true)
        
    }
    
    
}

