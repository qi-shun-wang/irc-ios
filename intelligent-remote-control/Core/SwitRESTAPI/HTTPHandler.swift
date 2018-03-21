//
//  HTTPHandler.swift
//  NFCAPP
//
//  Created by Wang QiShun on 2016/10/31.
//  Copyright © 2016年 mtntech. All rights reserved.
//

import Foundation

class HTTPHandler {
    
    static let Use = HTTPHandler()
    private init(){}
    
    /**
     HTTP GET
     */
    func get(url:String,body:[String:Any]? = nil,lang:String = "",result:@escaping (Data?,HTTPURLResponse?)->Void){
        
        DispatchQueue.global(qos: .background).async {
            
            guard let removedEmojiURL = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
                result(nil,nil)
                return
            }
            
            var req = URLRequest(url: URL(string: removedEmojiURL)!)
            
            req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            req.setValue(lang, forHTTPHeaderField: "accept-language")
            if let current_token = self.token {
                req.setValue(current_token, forHTTPHeaderField: "Authorization")
            }
            if let current_cookie = self.cookie {
                req.setValue(current_cookie, forHTTPHeaderField: "Cookie")
            }
            
            
            req.httpMethod = "GET"
            
            
            if let body = body {
                req.httpBody = try! JSONSerialization.data(withJSONObject: body, options: [])
            }
            
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(15)
            configuration.timeoutIntervalForResource = TimeInterval(15)
            let session = URLSession(configuration: configuration)
            
            session.dataTask(with: req) { data , response , error in
                
                guard let response = response as? HTTPURLResponse ,response.statusCode == 200 else {
                    result(nil,nil)
                    return
                }
                
                
                if let cookie = response.allHeaderFields["Set-Cookie"] as? String {
                    self.cookieFactoryFetching(cookie)
                    
                }
//                if let api_key = response.allHeaderFields["api_key"] {
//                    self.save(api_key:api_key)
//                }
                
                DispatchQueue.main.async {
                    
                    result(data,response)
                }
                
                
                }.resume()
            
        }
        
    }
    
    
    
    
    
    /**
     HTTP POST
     */
    func post(url:String,body:[String:Any]? = nil,result:@escaping (Data?,HTTPURLResponse?)->Void){
        
        
        DispatchQueue.global(qos: .background).async {
            
            var req = URLRequest(url: URL(string: url)!)
            
            req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            if let current_token = self.token {
                req.setValue(current_token, forHTTPHeaderField: "Authorization")
            }
            
            if let current_cookie = self.cookie {
                req.setValue(current_cookie, forHTTPHeaderField: "Cookie")
            }
            
            //test for redis cache
            //            req.setValue(self.api_key , forHTTPHeaderField: "api_key")
            req.httpMethod = "POST"
            
            
            if let body = body {
                req.httpBody = try! JSONSerialization.data(withJSONObject: body, options: [])
            }
            
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(15)
            configuration.timeoutIntervalForResource = TimeInterval(15)
            let session = URLSession(configuration: configuration)
            
            session.dataTask(with: req) { data , response , error in
                
                guard let response = response as? HTTPURLResponse ,response.statusCode == 200 else {
                    result(nil,nil)
                    return
                }
                
                
                if let cookie = response.allHeaderFields["Set-Cookie"] as? String {
                    self.cookieFactoryFetching(cookie)
                    
                }
                
                //                if let api_key = response.allHeaderFields["api_key"] {
                //                    self.save(api_key:api_key)
                //                }
                DispatchQueue.main.async {
                    result(data,response)
                }
                
                
                }.resume()
            
        }
    }
    
    
    /**
     HTTP DELETE
     */
    func delete(url:String,body:[String:Any]? = nil,result:@escaping (Data?,HTTPURLResponse?)->Void){
        
        
        DispatchQueue.global(qos: .background).async {
            
            var req = URLRequest(url: URL(string: url)!)
            
            req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            if let current_token = self.token {
                req.setValue(current_token, forHTTPHeaderField: "Authorization")
            }
            
            if let current_cookie = self.cookie {
                req.setValue(current_cookie, forHTTPHeaderField: "Cookie")
            }
            
            //test for redis cache
            //            req.setValue(self.api_key , forHTTPHeaderField: "api_key")
            req.httpMethod = "DELETE"
            
            
            if let body = body {
                req.httpBody = try! JSONSerialization.data(withJSONObject: body, options: [])
            }
            
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = TimeInterval(15)
            configuration.timeoutIntervalForResource = TimeInterval(15)
            let session = URLSession(configuration: configuration)
            
            session.dataTask(with: req) { data , response , error in
                
                guard let response = response as? HTTPURLResponse ,response.statusCode == 200 else {
                    result(nil,nil)
                    return
                }
                
                
                if let cookie = response.allHeaderFields["Set-Cookie"] as? String {
                    self.cookieFactoryFetching(cookie)
                    
                }
                
                //                if let api_key = response.allHeaderFields["api_key"] {
                //                    self.save(api_key:api_key)
                //                }
                DispatchQueue.main.async {
                    result(data,response)
                }
                
                
                }.resume()
            
        }
    }

    
    
    
    
    /**
     Upload image
     */
    func upload(url:String,image_data:Data,result:@escaping (Data?,HTTPURLResponse?)->Void) {
        let boundary = "Boundary-redsgewrfdgwqeafshy5t4rgg345gfds"
        let request = NSMutableURLRequest(url: URL(string:url)!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        if let current_token = self.token {
            request.setValue(current_token, forHTTPHeaderField: "Authorization")
        }
        if let current_cookie = self.cookie {
            request.setValue(current_cookie, forHTTPHeaderField: "Cookie")
        }
        
        let body = NSMutableData()
        
        let fname = "test.jpg"
        
        let mimetype = "image/jpg"
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("Content-Disposition:form-data; name=\"test\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        
        
        
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        
        body.append(image_data)
        
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        
        
        request.httpBody = body as Data
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let response = response as? HTTPURLResponse ,response.statusCode == 200 else {
                result(nil,nil)
                return
            }
            
            result(data,response)
            
        }
        
        task.resume()
    }
    
    
    ///Download Image
    func downloadImage(by url: URL,result:@escaping(Bool,Data?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil else {
                    result(false,nil)
                    return
                }
                
                DispatchQueue.main.async() { () -> Void in
                    result(true,data)
                }
                
                
                
            }
            task.resume()
            
            
        }
    }
    
    
    /**
     Set-Cookie
     */
    fileprivate var cookie :String? {
        get {
            return UserDefaults.standard.object(forKey: "cookie") as? String
        }
    }
    
    /**
     Save cookie
     */
    fileprivate func save(_ cookie:Any){
        UserDefaults.standard.set(cookie, forKey: "cookie")
        UserDefaults.standard.synchronize()
    }
    
    /**
     Delete cookie when signed out
     */
    func cleanCookie(){
        UserDefaults.standard.removeObject(forKey: "cookie")
        UserDefaults.standard.synchronize()
        
        
    }
    
    
    /**
     api_key
     */
    fileprivate var api_key :String? {
        get {
            return UserDefaults.standard.object(forKey: "api_key") as? String
        }
    }
    
    /**
     Save api_key
     */
    fileprivate func save(api_key:Any){
        UserDefaults.standard.set(api_key, forKey: "api_key")
        UserDefaults.standard.synchronize()
    }
    
    /**
     Delete api_key when signed out
     */
    func cleanApikey(){
        UserDefaults.standard.removeObject(forKey: "api_key")
        UserDefaults.standard.synchronize()
        
        
    }
    
    
    /**
     Authorization
     */
    fileprivate var token :String? {
        get {
//            guard let t =  UserDefaults.standard.object(forKey: "token") as? String ,t != "Bearer " else {
//                guard let ut = AccountService.Use.currentAccount()?.token else {
//                    return nil
//                }
//                save(token: ut)
//                return ut
//            }
            return nil//t
        }
    }
    
    /**
     Save token
     */
    public func save(token:Any){
        UserDefaults.standard.set("Bearer \(token)", forKey: "token")
        UserDefaults.standard.synchronize()
    }
    
    /**
     Delete token when signed out
     */
    func cleanToken(){
        UserDefaults.standard.removeObject(forKey: "token")
        UserDefaults.standard.synchronize()
        
        
    }
    
    func cookieFactoryFetching(_ cookie:String) {
        if cookie.contains("vapor-session") {
            
            var cookie_fragment:[String:Any] = [:]
            cookie.components(separatedBy: ";").forEach({ (component) in
                if component.contains("vapor-session=") {
                    cookie_fragment["vapor-session"] = component
                }
                
                
            })
            
            self.save(cookie_fragment["vapor-session"] ?? "")
        }
    }
    
}





extension String{
    var urlEncode:String?{
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'\\\"();:@&=+$,/?%#[]% ").inverted)
    }
}
