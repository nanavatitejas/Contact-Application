//
//  APIManager.swift
//  ContactApp
//
//  Created by Tejash P on 30/07/19.
//  Copyright © 2019 Tejash P. All rights reserved.
//

import Foundation

class APIManager {

static let shared: APIManager = APIManager()

// constants
    static private let gojekBaseUrl: String             = "http://gojek-contacts-app.herokuapp.com"
    static private let gojekContactExtensionUrl: String = "/contacts.json"
    static private let didDownloadKey                   = "didDownloadGojekContactsKey"
    static public let alphabet: [String]                = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "#"]
    
    
    static public func gojekUrl() -> String {
        return APIManager.gojekBaseUrl + APIManager.gojekContactExtensionUrl
    }
    
    

    
    // donwload contact image to a designated
    static public func downloadImage(stringUrl: String) -> Data? {
        if let url = URL(string: stringUrl) {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
    
    
}
