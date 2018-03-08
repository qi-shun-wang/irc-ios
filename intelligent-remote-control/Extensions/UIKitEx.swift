//
//  UIKitEx.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/15.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit
enum UserDeviceType:String {
    case iPodTouch5 = "iPod Touch 5"
    case iPodTouch6 = "iPod Touch 6"
    case iPhone4 = "iPhone 4"
    case iPhone5 = "iPhone 5"
    case iPhone5c = "iPhone 5c"
    case iPhone5s = "iPhone 5s"
    case iPhone6 = "iPhone 6"
    case iPhone6P = "iPhone 6 Plus"
    case iPhone7 = "iPhone 7"
    case iPhone7P = "iPhone 7 Plus"
    case iPhoneSE = "iPhone SE"
    case none = "not an iPhone device"
}
extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}

extension UINavigationBar {
    
    func transparentNavigationBar() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
    }
  
    func realNavigationBarFrame()->CGRect {
        let realWidth = frame.width
        let realHeight = frame.height + statusBarHeight()
        return CGRect(x: 0, y: 0, width: realWidth, height: realHeight)
    }
    
}

extension UIViewController {
    typealias ButtonCallback = ((UIButton)->Void)
    typealias BooleanCallback = ((Bool)->Void)
    typealias Callback = (()->Void)
}

extension UIView {
    typealias ButtonCallback = ((UIButton)->Void)
    typealias BooleanCallback = ((Bool)->Void)
    typealias Callback = (()->Void)
    func statusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    func statusBarWidth() -> CGFloat {
        return UIApplication.shared.statusBarFrame.width
    }
}

 

extension UITextField {
    func modifyClearButton(with image : UIImage) {
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(image, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(UITextField.clear(_:)), for: .touchUpInside)
        rightView = clearButton
        rightViewMode = .whileEditing
    }
    
    @objc func clear(_ sender : AnyObject) {
        self.text = ""
        sendActions(for: .editingChanged)
    }
}

extension UIColor {
    func convertImage() -> UIImage {
        let rect : CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context : CGContext = UIGraphicsGetCurrentContext()!
        
        context.setFillColor(self.cgColor)
        context.fill(rect)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

