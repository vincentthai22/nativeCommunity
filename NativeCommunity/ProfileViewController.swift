//
//  ProfileViewController.swift
//  NativeCommunity
//
//  Created by Vincent on 12/29/16.
//  Copyright © 2016 Seven Logics. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var numberOfPostsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profilePageProfileTabView: UIView!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    
    var profilePagePageViewController : ProfilePagePageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {
            var img :UIImage
            img = #imageLiteral(resourceName: "person_icon")
            DispatchQueue.main.sync {
                self.profileImageView.image = img
            }
        }
        self.profilePagePageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfilePagePageViewController") as! ProfilePagePageViewController?
        self.profilePageProfileTabView.addSubview((self.profilePagePageViewController?.view)!)
    // self.profilePagePageViewController?.view.frame = self.profilePagePageViewer.bounds
        let backButton = UIBarButtonItem.init(title: "Back", style: .plain, target: self, action: #selector(backButtonHandler))
        self.navItem.leftBarButtonItem = backButton
        setupNavBar()
    }
    
    func setupNavBar() -> Void {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 1, green: 204/255, blue: 204/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navBar.barTintColor = UIColor.init(red: 1, green: 204/255, blue: 204/255, alpha: 1)
        self.navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navBar.tintColor = UIColor.white
        self.navItem.titleView?.tintColor = UIColor.white
    }
    
    
    func backButtonHandler(){
        self.dismiss(animated: true, completion: nil)
    }
}
