//
//  ProfileViewController.swift
//  NativeCommunity
//
//  Created by Vincent on 12/29/16.
//  Copyright © 2016 Seven Logics. All rights reserved.
//

import Foundation
import UIKit

protocol EditProfileDelegate : class {
    func onSave(profileData : [String : AnyObject]  )
}

class ProfileViewController: UIViewController, EditProfileDelegate {
    

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var numberOfPostsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profilePageProfileTabView: UIView!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var editProfileButton: UIButton!
    
    var profileDescription = [String : AnyObject]()
    var profileData = [String : AnyObject]()
    let profileDataStrings = ["username", "posts", "title"]
    let usernameIndex = 0, postsIndex = 1, titleIndex = 2
    
    var editProfileBut : UIButton?

    var profilePagePageViewController : ProfilePagePageViewController?
    var navController : UINavigationController?
    
    var delegate : EditProfileDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.delegate = self
        DispatchQueue.global().async {
            var img :UIImage
            img = #imageLiteral(resourceName: "person_icon")
            
            DispatchQueue.main.sync {
                self.profileImageView.image = img
            }
        }
        //set edit profile button to the bottom right of the screen
        self.editProfileBut = UIButton.init(frame: CGRect(x: self.profilePageProfileTabView.frame.maxX - 75, y: self.profilePageProfileTabView.frame.maxY - 75, width: 100, height: 50))
        self.editProfileBut?.titleLabel?.textColor = UIColor.black
        self.editProfileBut?.backgroundColor = UIColor.init(red: 1, green: 105/255, blue: 160/255, alpha: 0.5)
        self.editProfileBut?.setTitle("EditProfile", for: UIControlState.normal)
        //self.editProfileBut?.titleLabel?.text = "edit profile"
        self.editProfileBut?.addTarget(self, action: #selector(editProfileButtonHandler), for: UIControlEvents.touchUpInside)
        
        //set up tabs for profile page.
        self.profilePagePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePagePageViewController") as! ProfilePagePageViewController?
        print ("is my profile page viewcontroller being presented? \(self.profilePagePageViewController?.isBeingPresented)")
        if profileDescription.count != 0 {
            self.profilePagePageViewController?.testProfileData = self.profileDescription as! [String : String]
        }
        self.profilePageProfileTabView.addSubview((self.profilePagePageViewController?.view)!)
        
        self.profilePageProfileTabView.addSubview(self.editProfileBut!)
        self.profilePageProfileTabView.bringSubview(toFront: self.editProfileBut!)
        
        let backButton = UIBarButtonItem.init(title: "Back", style: .plain, target: self, action: #selector(backButtonHandler))
        self.navItem.leftBarButtonItem = backButton
        
        setupNavBar()
        
        self.userNameLabel.sizeToFit()
        self.titleLabel.sizeToFit()
        
        self.userNameLabel.text = self.profileData[self.profileDataStrings[self.usernameIndex]] as? String
        self.numberOfPostsLabel.text = (self.profileData[self.profileDataStrings[self.postsIndex]] as? String)?.appending(" posts ")
        self.titleLabel.text = self.profileData[self.profileDataStrings[self.titleIndex]] as? String
        
    }
    
    func editProfileButtonHandler () {
        
        print("editprof pressed")
        
        let editProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        editProfileViewController.editProfileData = (self.profilePagePageViewController?.testProfileData)! as [String : AnyObject]
        editProfileViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        editProfileViewController.delegate = self.delegate
        self.present(editProfileViewController, animated: true, completion: nil)
        
    }
    func setupNavBar() -> Void {
        
        self.navBar.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 120)
        self.navBar.barTintColor = UIColor.init(red: 240/255, green: 170/255, blue: 170/255, alpha: 1)
        self.navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navBar.tintColor = UIColor.white
        self.navItem.titleView?.tintColor = UIColor.white
    
        
    }
    
    internal func onSave(profileData : [String : AnyObject] ) {
        self.profilePagePageViewController?.testProfileData = profileData as! [String : String]
    }
    func backButtonHandler(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
