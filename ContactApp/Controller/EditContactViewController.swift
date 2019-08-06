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
        self.dismiss(animated: true, completion: nil)
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
