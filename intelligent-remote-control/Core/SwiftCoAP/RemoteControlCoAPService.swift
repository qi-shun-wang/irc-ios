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
    var address:String = "192.168.34.1"
    var port:UInt16 = 5683
    
    func setup(address:String){
        self.address = address
    }
    
    func wireCheck(callback:SCClientDelegate){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.confirmable,payload:nil)
        
        let uriPath = "wireCheck"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.delegate = callback
        coapClient.sendCoAPMessage(m, hostName: address, port: port)
    }
    //game pad
    func detectGameEventNumber(callback:SCClientDelegate){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.confirmable,payload:nil)
        
        let uriPath = "detectEvent"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.delegate = callback
        coapClient.sendCoAPMessage(m, hostName: address, port: port)
    }
    
    func gameEvent(eventNumber:Int, code:SendCode){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(eventNumber);\(code.rawValue);".data(using: .utf8))
        let uriPath = "gameEvent"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    func gameEventBegan(eventNumber:Int, code:SendCode){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(eventNumber);\(code.rawValue);".data(using: .utf8))
        let uriPath = "gameEventBegan"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    func gameEventEnd(eventNumber:Int, code:SendCode){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(eventNumber);\(code.rawValue);".data(using: .utf8))
        let uriPath = "gameEventEnd"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    //gameDPadEvent
    func gameDPadEvent(eventNumber:Int, code:SendCode){

        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(eventNumber);\(abs(code.rawValue));\(code.rawValue > 0 ? 1:-1);".data(using: .utf8))
        let uriPath = "gameDPadEvent"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    func gameDPadEventBegan(eventNumber:Int, code:SendCode){
        let direction = 1;
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(eventNumber);\(code.rawValue);\(direction);".data(using: .utf8))
        let uriPath = "gameDPadBegan"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    func gameDPadEventEnd(eventNumber:Int, code:SendCode){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(eventNumber);\(code.rawValue);".data(using: .utf8))
        let uriPath = "gameDPadEnd"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    func gameAxisEvent(eventNumber:Int, code:SendCode.game_axis,value:String){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(eventNumber);\(code.rawValue);\(value);".data(using: .utf8))
        let uriPath = "gameAxisEvent"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    func input(text:String){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(text)".data(using: .utf8))
        let uriPath = "textInput"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    func send(code:SendCode){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(code.rawValue)".data(using: .utf8))
        let uriPath = "sendEvent"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    func sendBegan(code:SendCode){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(code.rawValue)".data(using: .utf8))
        let uriPath = "sendEventBegan"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    func sendEnd(code:SendCode){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(code.rawValue)".data(using: .utf8))
        let uriPath = "sendEventEnd"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    func sendL(code:SendCode){
        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: SCType.nonConfirmable, payload: "\(code.rawValue)".data(using: .utf8))
        let uriPath = "sendLongPressedEvent"
        m.addOption(SCOption.uriPath.rawValue, data: uriPath.data(using: .utf8)!)
        coapClient.sendCoAPMessage(m, hostName:address,  port: port)
    }
    
    //keyevent is slower than sendevent
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
        print("---didReceiveMessage->:",message.payloadRepresentationString())
    }
    func swiftCoapClient(_ client: SCClient, didSendMessage message: SCMessage, number: Int) {
        print("---didSendMessage->:",message.payloadRepresentationString())
    }
    func swiftCoapClient(_ client: SCClient, didFailWithError error: Error) {
        print("---didFailWithError->:",error)
    }
}
