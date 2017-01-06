//
//  EditProfileViewController.swift
//  NativeCommunity
//
//  Created by Vincent on 1/5/17.
//  Copyright © 2017 Seven Logics. All rights reserved.
//

import Foundation
import UIKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var aboutTextField: UITextView!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var interestsTextFIeld: UITextView!
    @IBOutlet weak var birthYearTextField: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var editProfileData = [String : AnyObject] ()
    let editProfileStrings = ["About Me", "Birthday", "Location", "Interests", "Status"]
    let aboutMeIndex = 0, birthdayIndex = 1, locationIndex = 2, interestsIndex = 3, statusIndex = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpTextFields()
        
        DispatchQueue.global().async {
            
            let image = #imageLiteral(resourceName: "person_icon_small")
            
            DispatchQueue.main.sync {
                self.profileImageView.image = image
            }
        }
        self.statusTextField.text = self.editProfileData[self.editProfileStrings[self.statusIndex]] as! String?
        self.aboutTextField.text = self.editProfileData[self.editProfileStrings[self.aboutMeIndex]] as! String!
        self.locationTextField.text = self.editProfileData[self.editProfileStrings[self.locationIndex]] as! String?
        self.interestsTextFIeld.text = self.editProfileData[self.editProfileStrings[self.interestsIndex]] as! String!
        
    }
    func setUpTextFields() {
        
        self.statusTextField.placeholder = "How are you doing today?"
        
        let borderColor = UIColor.init(white: 0.9, alpha: 1).cgColor
        self.interestsTextFIeld.layer.borderColor = borderColor
        self.interestsTextFIeld.layer.borderWidth = 1
        self.interestsTextFIeld.layer.cornerRadius = 5
        self.aboutTextField.layer.borderColor = borderColor
        self.aboutTextField.layer.borderWidth = 1
        self.aboutTextField.layer.cornerRadius = 5
        
        
    }
    func setUpNavBar() {
        self.navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)
        self.navBar.barTintColor = UIColor.init(red: 240/255, green: 170/255, blue: 170/255, alpha: 1)
        self.navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navBar.tintColor = UIColor.white
        self.navItem.titleView?.tintColor = UIColor.white
        self.navItem.rightBarButtonItem = UIBarButtonItem.init(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(saveButtonHandler))
    }
    
    func saveButtonHandler(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func changeButtonHandler(_ sender: UIButton) {
        
        print("change photo clicked")
        
    }
}
