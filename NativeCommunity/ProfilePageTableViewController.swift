//
//  ProfilePageTableViewController.swift
//  NativeCommunity
//
//  Created by Vincent on 12/29/16.
//  Copyright © 2016 Seven Logics. All rights reserved.
//

import Foundation
import UIKit

class ProfilePageTableViewController: UITableViewController {
    
    var profileDataObject = [String : AnyObject]()
    var dataObject = [[String : AnyObject]]()
    
    let tabNames = ["PROFILE", "POSTS", "COMMENTS", "SETTINGS"]
    let profileTabIndex = 0, postsTabIndex = 1, commentsTabIndex = 2, settingsTabIndex = 3
    
    let profileSectionStrings = ["About Me", "Birthday", "Location", "Interests", "Status"]
    let aboutMeIndex = 0, birthdayIndex = 1, locationIndex = 2, interestsIndex = 3, statusIndex = 4
    
    let postsSectionStrings = ["title", "description", "time", "category"]
    let titleIndex = 0, descriptionIndex = 1, timeIndex = 2, postsCategoryIndex = 3
    
    let commentSectionStrings = ["comments", "category", "likes"]
    let commentsIndex = 0, commentsCategoryIndex = 1, likesIndex = 2

    var currentTab : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.currentTab == self.tabNames[profileTabIndex] {
            return self.profileDataObject.count
        } else {
            return self.dataObject.count
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.currentTab == self.tabNames[profileTabIndex] {
            
            if indexPath.row == 0 {
                let statusCell = cell as! StatusTableViewCell
                statusCell.statusLabel.text = self.profileDataObject[self.profileSectionStrings[self.statusIndex]] as! String?
                
            } else {
            
            let cell2 = cell as! ProfileTabTableViewCell
            _ = self.profileDataObject[self.profileSectionStrings[self.aboutMeIndex]] as! String?
            cell2.detailsLabel.sizeToFit()
            cell2.detailsLabel.numberOfLines = 0
            
            switch(indexPath.row - 1){
                
            case self.aboutMeIndex:
                cell2.sectionLabel.text = self.profileSectionStrings[self.aboutMeIndex]
                cell2.detailsLabel.text = self.profileDataObject[self.profileSectionStrings[self.aboutMeIndex]] as! String?
                break
            case self.birthdayIndex:
                cell2.sectionLabel.text = self.profileSectionStrings[self.birthdayIndex]
                cell2.detailsLabel.text = self.profileDataObject[self.profileSectionStrings[self.birthdayIndex]] as! String?
                break
            case self.locationIndex:
                cell2.sectionLabel.text = self.profileSectionStrings[self.locationIndex]
                cell2.detailsLabel.text = self.profileDataObject[self.profileSectionStrings[self.locationIndex]] as! String?
                break
            case self.interestsIndex:
                cell2.sectionLabel.text = self.profileSectionStrings[self.interestsIndex]
                cell2.detailsLabel.text = self.profileDataObject[self.profileSectionStrings[self.interestsIndex]] as! String?
                break
            default:
                break
                
            }
            }
            
        } else if self.currentTab == self.tabNames[self.postsTabIndex] {
            
            let cell2 = cell as! PostsTabTableViewCell
            cell2.descriptionLabel.sizeToFit()
            cell2.descriptionLabel.numberOfLines = 0
            
            cell2.titleLabel.text = self.dataObject[indexPath.row][self.postsSectionStrings[self.titleIndex]] as! String?
            cell2.descriptionLabel.text = self.dataObject[indexPath.row][self.postsSectionStrings[self.descriptionIndex]] as! String?
            cell2.timeLabel.text = self.dataObject[indexPath.row][self.postsSectionStrings[self.timeIndex]] as! String?
            cell2.categoryLabel.text = self.dataObject[indexPath.row][self.postsSectionStrings[self.postsCategoryIndex]] as! String?
    
        } else if self.currentTab == self.tabNames[self.commentsTabIndex] {
            
            let cell2 = cell as! CommentsTableViewCell
            
            cell2.commentsLabel.numberOfLines = 2
            cell2.commentsLabel.sizeToFit()
            
            cell2.categoryLabel.text = self.dataObject[indexPath.row][self.commentSectionStrings[self.commentsCategoryIndex]] as! String?
            cell2.commentsLabel.text = self.dataObject[indexPath.row][self.commentSectionStrings[self.commentsIndex]] as! String?
            cell2.likesNumberLabel.text = self.dataObject[indexPath.row][self.commentSectionStrings[self.likesIndex]] as! String?
            cell2.heartImageView.image = #imageLiteral(resourceName: "heart_icon")
        } else {
            
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.currentTab == self.tabNames[self.profileTabIndex] {
            
            if indexPath.row == 0 {
                let cellIdentifier = "StatusTableViewCell"
                let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! StatusTableViewCell
                return cell
            }
            let cellIdentifier = "ProfileTabTableViewCell"
            let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProfileTabTableViewCell
            cell.detailsLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
            return cell
        } else if self.currentTab == self.tabNames[self.postsTabIndex] {
            let cellIdentifier = "PostsTabTableViewCell"
            let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostsTabTableViewCell
            return cell
        } else {
            let cellIdentifier = "CommentsTableViewCell"
            let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommentsTableViewCell
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("selected row \(indexPath.row)")
    }
    
}
