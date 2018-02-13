//
//  String+TimeInterval.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/16.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

extension String {
    func parseDuration() -> TimeInterval {
        guard !self.isEmpty else {
            return 0
        }
        
        var interval:Double = 0
        
        let parts = self.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }
        
        return interval
    }
}

extension TimeInterval {
    func parseDuration() -> String {
        let hours = (Int(self) / 3600)
        let minutes = Int(self / 60) - Int(hours * 60)
        let seconds = Int(self) - (Int(self / 60) * 60)
        return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds) as String
    }
    
    func parseDuration2() -> String {
        let hours = (Int(self) / 3600)
        let minutes = Int(self / 60) - Int(hours * 60)
        let seconds = Int(self) - (Int(self / 60) * 60)
        return NSString(format: "%0.2d:%0.2d",minutes,seconds) as String
    }
}
