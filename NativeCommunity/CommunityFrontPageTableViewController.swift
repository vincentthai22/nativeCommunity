//
//  DataTableViewController.swift
//  NativeCommunity
//
//  Created by Vincent on 12/28/16.
//  Copyright © 2016 Seven Logics. All rights reserved.
//

import Foundation
import UIKit

class CommunityFrontPageTableViewController: UITableViewController {
    
    //2-D Array holding data for each individual post which will then be loaded into each individual table cell
    
    var dataObject : [[String : AnyObject]]!
    let dataStrings = ["question", "description", "username", "category"]
    let questionIndex = 0, descriptionIndex = 1, usernameIndex = 2, categoryIndex = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let askTheCommunityButton = UIButton.init(frame: CGRect.init(x: 250, y: 400, width: 200, height: 100))
//        askTheCommunityButton.imageView?.image = #imageLiteral(resourceName: "ask_the_community")
//        self.view.addSubview(askTheCommunityButton)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataObject.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell2 = cell as! TopTabTableViewCell
        let post = dataObject[indexPath.row]
        
        
        cell2.questionLabel.text = post[self.dataStrings[self.questionIndex]] as! String?
        cell2.descriptionLabel.text = post[self.dataStrings[self.descriptionIndex]] as! String?
        cell2.usernameLabel.text = post[self.dataStrings[self.usernameIndex]] as! String?
        cell2.categoryLabel.text = post[ self.dataStrings[self.categoryIndex]] as! String?
        
        DispatchQueue.global().async {
            var profileImg : UIImage?, heartIconImg:UIImage?, conversationIconImg:UIImage?, viewsIconImg:UIImage?
            do {
                try profileImg = UIImage.init(data: NSData.init(contentsOf: NSURL.init(fileURLWithPath: "http://www.contestofchampions.net/wp-content/themes/The-Boiler-0.1_Vorkshop/images/icon_ddu_off.svg") as URL) as Data)
            } catch {
                profileImg = #imageLiteral(resourceName: "person_icon")
            }
            heartIconImg = #imageLiteral(resourceName: "heart_icon")
            conversationIconImg = #imageLiteral(resourceName: "conversation_icon")
            viewsIconImg = #imageLiteral(resourceName: "eye_icon")
            DispatchQueue.main.sync {
                cell2.profileImageView.image = profileImg
                cell2.heartIconImageView.image = heartIconImg
                cell2.conversationIconImageView.image = conversationIconImg
                cell2.viewCountIconImageView.image = viewsIconImg
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TopTabTableViewCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TopTabTableViewCell
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("selected row \(indexPath.row)")
    }
    
}
