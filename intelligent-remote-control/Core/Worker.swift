//
//  Worker.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/17.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class Worker {
    
    init(durationOf second:TimeInterval = 10.0 ,repeatedAction:@escaping ()->Void) {
        self.repeatedAction = repeatedAction
        self.deltaT = second
    }
    
    var deltaT : TimeInterval = 10.0
    var repeatedAction:(()->Void)?
    var timer:Timer?
    var isPlaying:Bool = false {
        didSet {
            if isPlaying {
                startTimer()
            } else {
                killTimer()
            }
        }
    }
    final func killTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    
    final private func startTimer() {
        
        // make it re-entrant:
        // if timer is running, kill it and start from scratch
        self.killTimer()
        let fire = Date().addingTimeInterval(1)
        
        timer = Timer(fire: fire, interval: deltaT, repeats: true, block: { (t: Timer) in
            self.repeatedAction?()
        })
        
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
        
    }
}
