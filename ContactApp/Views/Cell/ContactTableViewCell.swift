//
//  ContactTableViewCell.swift
//  ContactApp
//
//  Created by Tejash P on 30/07/19.
//  Copyright © 2019 Tejash P. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var isFavoriteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contactImage.layer.cornerRadius = (self.contactImage.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.contactImage.layer.masksToBounds = true
        // Initialization code
    }

    func reloadCellData(contact : Contact) {
        
        let fName = contact.first_name ?? ""
        let lName = contact.last_name ?? ""
        
        contactName.text = fName + " " + lName

        isFavoriteImage.isHidden = contact.favorite ?? false
        
        self.contactImage.image = contact.image()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
