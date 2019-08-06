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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var contactArray = [Contact]()

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.tableFooterView = UIView()
        self.title = "Contact"
        self.showActivityIndicator()
        self.fetchContacts()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func showActivityIndicator() {
        self.spinner.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.spinner.stopAnimating()
    }
    
    
    
    
    

}


// MARK: IBActions


extension ContactViewController{
    
    @IBAction func addBtnPressed(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditContactViewController") as? EditContactViewController
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
}

// MARK: API CALL
extension ContactViewController{
    
    public func fetchContacts() {
        
        // prevent fetching contacts if we have already downloaded gojek contacts, or if we're currently fetching data
        
        
        
        
        // call gojek api
        let url = APIManager.gojekUrl()
        HTTPManager.shared.get(urlString: url, completionBlock: {(data: Data?) -> Void in
            
            if let d = data {
                var dataArr: [[String: Any]] = [[String: Any]]()
                
                // format contacts data to json
                do {
                    dataArr = try JSONSerialization.jsonObject(with: d, options: []) as! [[String: Any]]
                } catch {
                    print(error.localizedDescription)
                }
                
                // empty data
                if dataArr.count == 0 {
                    return
                }
                
                // loop through json array of contacts data
                for personData in dataArr {
                    
                    let contact = Contact()
                    
                    
                    if let id = personData["id"] as? Int {
                        contact.id = id
                    }
                    
                    
                    if let firstName = personData["first_name"] as? String {
                        contact.first_name  = firstName
                    }
                    
                    if let lastName = personData["last_name"] as? String {
                        contact.last_name  = lastName
                    }
                    
                    if let imgUrl = personData["profile_pic"] as? String {
                        // if url is missing then we set it to default
                        if imgUrl != "/images/missing.png" {
                            // download image
                            contact.imageData = APIManager.downloadImage(stringUrl: imgUrl)
                            
                        }
                    }
                    
                    if let isFavorite = personData["favorite"] as? Bool {
                        contact.favorite = isFavorite
                    }
                    
                    self.contactArray.append(contact)
                
                    
                }
                if self.contactArray.count > 0{
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.tblView.reloadData()
                    }
                }
                
            } else {
                self.hideActivityIndicator()

            }
            
        })
    }

    
    
    
    
}

extension ContactViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = self.contactArray[indexPath.row]
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ContactDetailViewController") as? ContactDetailViewController
        vc?.contact = contact
        self.navigationController?.pushViewController(vc!, animated: true)


        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
}

extension ContactViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath) as! ContactTableViewCell
        let contact = self.contactArray[indexPath.row]
        contactCell.reloadCellData(contact: contact)
        return contactCell
    }
    
    
}
