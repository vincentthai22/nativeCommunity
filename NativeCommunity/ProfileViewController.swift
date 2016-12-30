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
    }
    
}
