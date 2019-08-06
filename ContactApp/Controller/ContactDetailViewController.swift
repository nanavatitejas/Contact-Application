//
//  ContactDetailViewController.swift
//  ContactApp
//
//  Created by Tejash P on 30/07/19.
//  Copyright © 2019 Tejash P. All rights reserved.
//

import UIKit


let CellIdentifierDetail = "ContactDetailTableViewCell"


class ContactDetailViewController: UIViewController {

    
    var contact : Contact?
    
    
    @IBOutlet weak var tblView: UITableView!

    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var lblName: UILabel!

    @IBOutlet weak var spinner: UIActivityIndicatorView!

     private let lightGreen : UIColor = UIColor(red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1.0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.tableFooterView = UIView()
        self.showActivityIndicator()
        self.fetchContactsDetails()
        let fName = contact?.first_name ?? ""
        let lName = contact?.last_name ?? ""
        
        lblName.text = fName + " " + lName
        
        self.profilePic.layer.cornerRadius = (self.profilePic.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.profilePic.layer.masksToBounds = true

        self.profilePic.image = contact?.image()
        self.headerViewSetBackGroundColor()
        self.navigationController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.init(red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1.0)

        navigationItem.leftBarButtonItem?.tintColor = UIColor.init(red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1.0)

        // Do any additional setup after loading the view.
    }
    
    func headerViewSetBackGroundColor() {
        let gradient  : CAGradientLayer = CAGradientLayer()
        
        self.headerView.backgroundColor = .white
        gradient.colors = [UIColor.white.cgColor, lightGreen.cgColor]
        gradient.locations = [0.06, 1.0]
        gradient.opacity = 0.55
        self.headerView.layer.insertSublayer(gradient, at: 0)
    }
    
    func showActivityIndicator() {
        self.spinner.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.spinner.stopAnimating()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ContactDetailViewController{
    public func fetchContactsDetails() {
        
        // prevent fetching contacts if we have already downloaded gojek contacts, or if we're currently fetching data
        
        
        
        
        // call gojek api
        var url = APIManager.gojekUrlDetail()
        var strID : String?
        if let id = contact?.id{
             strID = "\(id)"

        }
        
        
        strID = "/" + strID! + ".json"

        // http://gojek-contacts-app.herokuapp.com/contacts/62.json
        url = url + strID!
        
        HTTPManager.shared.get(urlString: url, completionBlock: {(data: Data?) -> Void in
            
            if let d = data {
            
                var dataArr: [String: Any] = [String: Any]()
                
                // format contacts data to json
                do {
                    dataArr = try JSONSerialization.jsonObject(with: d, options: []) as! [String: Any]
                } catch {
                    print(error.localizedDescription)
                }
                
                // empty data
                if dataArr.count == 0 {
                    return
                }
                
                // loop through json array of contacts data
                    if let phone_number = dataArr["phone_number"] as? String {
                        self.contact?.phone_number = phone_number
                    }
                
                    if let email = dataArr["email"] as? String {
                        self.contact?.email = email
                    }

                   
                    
                    
                    
                
                    DispatchQueue.main.async {
                        self.hideActivityIndicator()
                        self.tblView.reloadData()
                    }
            } else {
                self.hideActivityIndicator()
            }
                
            }
            
        )
    }
    
    

}

extension ContactDetailViewController{
    
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditContactViewController") as? EditContactViewController
        vc?.contact = contact
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
}


extension ContactDetailViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
}

extension ContactDetailViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierDetail, for: indexPath) as! ContactDetailTableViewCell
        switch indexPath.row {
        case 0:
            contactCell.lblKey.text = "mobile"
            contactCell.lblValue.text = contact?.phone_number
        default:
            contactCell.lblKey.text = "email"
            contactCell.lblValue.text = contact?.email
        }
        return contactCell
    }
    
    
}
