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
    
    //An array of dictionaries holding data for each individual post which will then be loaded into each individual table cell
    var dataObject : [[String : AnyObject]]!
    let dataStrings = ["question", "description", "username", "category"]
    let questionIndex = 0, descriptionIndex = 1, usernameIndex = 2, categoryIndex = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let askTheCommunityButton = UIButton.init(frame: CGRect.init(x: 250, y: 400, width: 200, height: 100))
//        askTheCommunityButton.imageView?.image = #imageLiteral(resourceName: "ask_the_community")
//        self.view.addSubview(askTheCommunityButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataObject.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell2 = cell as! TopTabTableViewCell
        let post = self.dataObject[indexPath.row]
        
        //assign data to labels
        cell2.questionLabel.text = post[self.dataStrings[self.questionIndex]] as! String?
        cell2.descriptionLabel.text = post[self.dataStrings[self.descriptionIndex]] as! String?
        cell2.usernameLabel.text = post[self.dataStrings[self.usernameIndex]] as! String?
        cell2.categoryLabel.text = post[ self.dataStrings[self.categoryIndex]] as! String?
        
        //re-format the labels to be next to eachother
            var tempText : NSString?
            let font = UIFont(name: "Helvetica", size: 13.0)!
            tempText = cell2.usernameLabel.text as NSString!  //get length of username text
            let usernameTextSize = tempText?.size(attributes: [NSFontAttributeName: font])
            tempText = cell2.postedInLabel.text as NSString! //get length of "posted in" text
            let postedInTextSize = tempText?.size(attributes: [NSFontAttributeName: font])
            cell2.postedInLabel.frame = CGRect(x: cell2.usernameLabel.frame.origin.x + (usernameTextSize?.width)! + 5, y: cell2.postedInLabel.frame.origin.y, width: cell2.postedInLabel.frame.size.width, height: cell2.postedInLabel.frame.size.height)
            cell2.categoryLabel.frame = CGRect(x: cell2.postedInLabel.frame.origin.x + (postedInTextSize?.width)! + 5, y: cell2.postedInLabel.frame.origin.y, width: cell2.categoryLabel.frame.size.width, height: cell2.postedInLabel.frame.size.height)
        
        //load images in background thread
        DispatchQueue.global().async {
            //store images in a temp variable
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
                //load images from temp variable to actual variables within the cell
                cell2.profileImageView.image = profileImg
                cell2.heartIconImageView.image = heartIconImg
                cell2.conversationIconImageView.image = conversationIconImg
                cell2.viewCountIconImageView.image = viewsIconImg
                
            }//END OF MAIN THREAD
            
        }//END OF BACKGROUND THREAD
        
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
