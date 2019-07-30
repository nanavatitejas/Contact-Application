//
//  ViewController.swift
//  ContactApp
//
//  Created by Tejash P on 30/07/19.
//  Copyright © 2019 Tejash P. All rights reserved.
//

import UIKit


let CellIdentifier = "ContactTableViewCell"

class ContactViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.tableFooterView = UIView()
        self.title = "Contact"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
    }
    

}

extension ContactViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension ContactViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! ContactTableViewCell
        
        contactCell.reloadCellData()
        return contactCell
    }
    
    
}
