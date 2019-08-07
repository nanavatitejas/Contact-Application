//
//  ContactDetailTableViewCell.swift
//  ContactApp
//
//  Created by Tejash P on 31/07/19.
//  Copyright © 2019 Tejash P. All rights reserved.
//

import UIKit

class ContactDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    @IBOutlet weak var txtValue: UITextField!


    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
