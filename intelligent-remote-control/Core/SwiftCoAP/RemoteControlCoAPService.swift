//
//  RemoteControlCoAPService.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/25.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import SwiftyJSON

class RemoteControlCoAPService {
    
    static let shared:RemoteControlCoAPService = RemoteControlCoAPService()
    private init(){}
    
    lazy var coapClient:SCClient = SCClient(delegate: self)
    var address:String = ""
    var port:UInt16 = 5683
    
    func setup(address:String){
        self.address = address
    }
    
    func input(text:String){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(text)".data(using: .utf8))
        let uriPath = "textInput"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    func key(code:KeyCode){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(code.rawValue)".data(using: .utf8))
        let uriPath = "keyEvent"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    func motion(_ serialNumber:String){
        
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: .confirmable, payload: serialNumber.data(using: .utf8))
        
        let uriPath = "mouseEvent"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        print("----->",serialNumber)
        coapClient.sendCoAPMessage(m, hostName:address,  port: 5683)
    }
    
    func tap(){
        let payload:[String:String] = ["Code":"2"]
        let json = JSON(payload)
        let payloadData = try! json.rawData()
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: .confirmable, payload: payloadData)
        let uriPath = "mouseEvent"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: 5683)
    }
    
}
extension RemoteControlCoAPService:SCClientDelegate {
    
    func swiftCoapClient(_ client: SCClient, didReceiveMessage message: SCMessage) {
        print("---didReceiveMessage->:",JSON(message.payload))
    }
    func swiftCoapClient(_ client: SCClient, didSendMessage message: SCMessage, number: Int) {
        print("---didSendMessage->:",message)
    }
    func swiftCoapClient(_ client: SCClient, didFailWithError error: Error) {
        print("---didFailWithError->:",error)
    }
}
