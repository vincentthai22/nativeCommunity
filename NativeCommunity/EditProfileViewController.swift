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
    @IBOutlet weak var changePhotoLabel: UILabel!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var aboutTextField: UITextView!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var interestsTextFIeld: UITextView!
    @IBOutlet weak var birthYearTextField: UITextField!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpTextFields()
    }
    func setUpTextFields() {
        self.statusTextField.placeholder = "How are you doing today?"
    }
    func setUpNavBar() {
        self.navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60)
        self.navBar.barTintColor = UIColor.init(red: 1, green: 153/255, blue: 204/255, alpha: 1)
        self.navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navBar.tintColor = UIColor.white
        self.navItem.titleView?.tintColor = UIColor.white
    }
}
