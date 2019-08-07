//
//  HttpManager.swift
//  ContactApp
//
//  Created by Tejash P on 30/07/19.
//  Copyright © 2019 Tejash P. All rights reserved.
//

import Foundation


import Foundation

// Singleton used to execute HTTP request and return it's response
// currently just support GET request and simply returns the content
// without error codes or messages, returns nil in case of error

class HTTPManager {
    
    private init() { }
    
    // MARK: Shared Instance
    static let shared: HTTPManager = HTTPManager()
    
    // get request, run synchronously for threading simplicity
    public func get(urlString: String, completionBlock: ((Data?) -> Void)?) {
        
        let url = URL(string: urlString)
        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                completionBlock?(data)
            })
            task.resume()
        }
    }
    
    public func put(urlString: String, param : [String : Any],completionBlock: ((Data?) -> Void)?) {
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: param)
        
        // create post request
        let url = URL(string: urlString)
        if let usableUrl = url {
            var request = URLRequest(url: usableUrl)
            

            request.httpMethod = "PUT"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

            // insert json data to the request
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                completionBlock?(data)
            })
            
            task.resume()
        }
       
    }
    
    public func post(urlString: String, param : [String : Any],completionBlock: ((Data?) -> Void)?) {
        
        
        let jsonData = try? JSONSerialization.data(withJSONObject: param)
        
        // create post request
        let url = URL(string: urlString)
        if let usableUrl = url {
            var request = URLRequest(url: usableUrl)
            
            
            request.httpMethod = "PUT"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            // insert json data to the request
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                completionBlock?(data)
            })
            
            task.resume()
        }
        
    }
    
    
    
    
}
