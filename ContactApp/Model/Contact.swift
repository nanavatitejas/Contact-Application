//
//  Contact.swift
//  ContactApp
//
//  Created by Tejash P on 30/07/19.
//  Copyright © 2019 Tejash P. All rights reserved.
//

import UIKit

class Contact: NSObject {
    
    var id : Int?
    var first_name: String?
    var last_name : String?
    var profile_pic : String?
    var favorite : Bool?
    var url : String?
    var imageData     : Data?
    
    
    func image() -> UIImage {
        
        var finalImage: UIImage = UIImage(named: "placeholder_photo")!
        if let data = self.imageData, let image = UIImage(data: data) {
            finalImage = image
        }
        
        return finalImage
    }

}
