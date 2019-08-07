//
//  EditContactViewController.swift
//  ContactApp
//
//  Created by Tejash P on 31/07/19.
//  Copyright © 2019 Tejash P. All rights reserved.
//

import UIKit

let CellIdentifierEditDetail = "ContactEditDetailTableViewCell"


class EditContactViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    
    @IBOutlet weak var navBar: UINavigationBar!

    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var openCamera: UIImageView!

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var contact : Contact?
    
    var isEdit : Bool?
    

    
    override func viewDidLoad() {
        
        
        if contact == nil {
            navBar.topItem?.title = "Add Contact"

        }
        
        super.viewDidLoad()
        self.tblView.tableFooterView = UIView()
        self.profilePic.layer.cornerRadius = (self.profilePic.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.profilePic.layer.masksToBounds = true
        self.profilePic.isUserInteractionEnabled = true
        
        
        self.openCamera.layer.cornerRadius = (self.openCamera.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.openCamera.layer.masksToBounds = true
        self.profilePic.clipsToBounds = true

        
        self.addGestureToImageView()

        // Do any additional setup after loading the view.
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


extension EditContactViewController: UIGestureRecognizerDelegate{
    func addGestureToImageView(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.openCameraButton))
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        self.profilePic.addGestureRecognizer(tapGesture)

    }
}

extension EditContactViewController{
    
    @IBAction func cancelBtnPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnPressed(_ sender: UIBarButtonItem) {
        
        if self.isEdit == false{
            self.addContact()
        } else {
            self.editContact()
            
           // self.navigationController?.popToRootViewController(animated: true)
           
            

        }
    }
    
    func editContact(){
        var url = APIManager.gojekUrlDetail()
        
        var strID : String?
        if let id = contact?.id{
            strID = "\(id)"
            
        }
        
        
        strID = "/" + strID! + ".json"
        
        // http://gojek-contacts-app.herokuapp.com/contacts/62.json
        url = url + strID!
        
        
        let param = ["first_name": self.contact?.first_name as Any,"last_name":self.contact?.last_name as Any,"phone_number":self.contact?.phone_number as Any,"email":self.contact?.email as Any,"favorite":false] as [String : Any]
        
        HTTPManager.shared.put(urlString: url, param: param) { (data : Data?) -> Void in
            if let d = data{
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
                
               self.dismiss(animated: false, completion: nil)

            }
        }
        
        
    }
    
    
    func addContact(){
        let url = APIManager.gojekUrl()
        
       
        
        
        
        let param = ["first_name": self.contact?.first_name as Any,"last_name":self.contact?.last_name as Any,"phone_number":self.contact?.phone_number as Any,"email":self.contact?.email as Any,"favorite":false] as [String : Any]
        
        HTTPManager.shared.post(urlString: url, param: param) { (data : Data?) -> Void in
            if let d = data{
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
                
                self.dismiss(animated: false, completion: nil)
                
            }
        }
        
        
    }

}

extension EditContactViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func openCameraButton() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
}



extension EditContactViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
    
}

extension EditContactViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifierEditDetail, for: indexPath) as! ContactDetailTableViewCell
        contactCell.lblValue.isHidden = true
        contactCell.txtValue.tag = indexPath.row
        contactCell.txtValue.delegate = self
        contactCell.txtValue.isHidden = false
        contactCell.txtValue.isUserInteractionEnabled = true
        switch indexPath.row {
        case 0:
            contactCell.lblKey.text = "First Name"
            contactCell.txtValue.text = contact?.first_name
        case 1:
            contactCell.lblKey.text = "Last Name"
            contactCell.txtValue.text = contact?.last_name
        case 2:
            contactCell.lblKey.text = "mobile"
            contactCell.txtValue.text = contact?.phone_number
        default:
            contactCell.lblKey.text = "email"
            contactCell.txtValue.text = contact?.email
        }
        return contactCell
    }
    
    
}

extension EditContactViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0{
            self.contact?.first_name = textField.text
        }
        if textField.tag == 1{
            self.contact?.last_name = textField.text
        }
        if textField.tag == 2{
            self.contact?.phone_number = textField.text
        }
        if textField.tag == 3{
            self.contact?.email = textField.text
        }
        textField.resignFirstResponder()
        return true
    }
}
