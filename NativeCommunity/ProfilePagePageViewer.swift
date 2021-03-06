//
//  ProfilePagePageViewer.swift
//  NativeCommunity
//
//  Created by Vincent on 12/29/16.
//  Copyright © 2016 Seven Logics. All rights reserved.
//

import Foundation
import UIKit

class ProfilePagePageViewController: RGPageViewController, RGPageViewControllerDelegate, RGPageViewControllerDataSource {
    
    /* Data structure process:
     *--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     * 1)Retrieve and store data     2) Determine when and which set of data to load.
     * Server call --> 'data' array --> 'tabs' dictionary --> repeat for each tab on page viewer
     *
     * Retrieve and store data -- if "TOP" tab is the desired data to be loaded, load all posts into the "data" array then store this data into the "tabs" dictionary respective to its key, in this case its "TOP".
     * Determine which set of data -- The current pageIndex from viewControllerForPageIndex (current tab) will determine which set of data is to be loaded and which view to be displayed.
     *--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     */
    
    // an array of dictionaries, each dictionary holds information related to post
    var data: [[String: AnyObject]] = []
    
    //Dictionary that holds an array of dictionaries respective to each tab.
    var tabs = ["PROFILE" : [[String : AnyObject]](), "POSTS" : [[String : AnyObject]](), "COMMENTS" : [[String:AnyObject]](), "SETTINGS" : [[String : AnyObject]]()]
    let tabNames = ["PROFILE", "POSTS", "COMMENTS", "SETTINGS"]
    let profileTabIndex = 0, postsTabIndex = 1, commentsTabIndex = 2, settingsTabIndex = 3
    var tabViews = [UILabel]()
    //tab names used to retrieve each array of dictionaries from the "tabs" dictionary.
    
    
    //Dummy data
    var testProfileData = ["About Me" : "Hi I'm Jilian and my favorite thing in the world is to dance!", "Birthday" : "Oct 17, 1993 (23)", "Location" : "San Marino, CA", "Interests" : "dancing, picnics, music", "Status" : "Hello! Nice to meet you!"]
    let testPostsData = [[ "title" : "Is it worth it?", "description" : "I've been on Lutera (BC pills) for about two months now . . .", "time" : "2 mins ago in" , "category" : "Period Questions"], ["title" : "Should I be worred?", "description" : "Hello guys I am new to the period community but I thought", "time" : "3 weeks ago in" , "category" : "Period Questions"], ["title" : "Cramping before period? Did you have implantation cramping before your period?", "description" : " ", "time" : "8 months ago" , "category" : "Period Questions"]]
    let testCommentsData = [["comments" : "No its okay, I thought if someone had the same problem they could tell me. Besides, if I wasn't", "category" : "Tampons", "likes" : "0" ],["comments" : "Do you think it could be becuase your boyfriend problem they could tell me. Besides, if I wasn't...", "category" : "Tampons", "likes" : "0" ],["comments" : "Have a good time! I'm sure you guys will get to see the show or even at least on the board ...", "category" : "I'm going on vacation we're going to the Sha..", "likes" : "0" ],["comments" : "Is it itchy? I used to have a similar condition it turned out to be a second for lorem ipsum, r..", "category" : "Question??", "likes" : "0" ]]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.datasource = self
        self.delegate = self
        
        self.data = [self.testProfileData as Dictionary<String, AnyObject>]
        
        self.tabs[self.tabNames[profileTabIndex]] = self.data
        self.tabs[self.tabNames[postsTabIndex]] = self.testPostsData as [[String : AnyObject]]?
        self.tabs[self.tabNames[commentsTabIndex]] = self.testCommentsData as [[String : AnyObject]]?
        self.tabbar.frame = CGRect.init(x: 0, y: -3, width: view.bounds.width, height: self.tabbarHeight)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.data = [self.testProfileData as Dictionary<String, AnyObject>]
        self.tabs[self.tabNames[self.profileTabIndex]] = self.data
        self.reloadData()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.currentTabIndex = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.currentTabIndex = 0
    }
    // MARK: - RGPageViewController Data Source
    func numberOfPagesForViewController(_ pageViewController: RGPageViewController) -> Int {
        return self.tabNames.count
    }
    
    func tabViewForPageAtIndex(_ pageViewController: RGPageViewController, index: Int) -> UIView {
        var tabView: UILabel?
        
        tabView = UILabel()
        
        tabView?.font = UIFont.systemFont(ofSize: 14)
        tabView?.text = self.tabNames[index]
        if self.currentTabIndex == index {
            tabView?.textColor = UIColor.init(red: 1, green: 153/255, blue: 204/255, alpha: 1)
        } else {
            tabView?.textColor = UIColor.darkGray
        }
        tabView?.sizeToFit()
        
        self.tabViews.append(tabView!)
        print ("index \(index)")
        
        return tabView!
    }
    
    override func updateTabColor(index: Int) {
        for i in 1..<self.tabViews.count {
            //print ("i is \(i) tabviewCounts \(self.tabViews.count)")
            if index+1 == i{
                self.tabViews[i].textColor =  UIColor.init(red: 1, green: 153/255, blue: 204/255, alpha: 1)
            } else {
                self.tabViews[i].textColor = UIColor.darkGray
            }
        }
        
    }
    func viewControllerForPageAtIndex(_ pageViewController: RGPageViewController, index: Int) -> UIViewController? {
        if (self.tabNames.count == 0) || (index >= self.tabNames.count) {
            //print ("index is \(index)")
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let dataViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfilePageTableViewController") as! ProfilePageTableViewController
        switch (index) {
        case self.profileTabIndex:
            dataViewController.currentTab = self.tabNames[self.profileTabIndex]
            dataViewController.profileDataObject = (self.tabs[self.tabNames[self.profileTabIndex]]?[self.profileTabIndex])!
            return dataViewController
        case self.postsTabIndex:
            dataViewController.currentTab = self.tabNames[self.postsTabIndex]
            dataViewController.dataObject = self.tabs[self.tabNames[self.postsTabIndex]]!
            return dataViewController
        case self.commentsTabIndex :
            dataViewController.currentTab = self.tabNames[self.commentsTabIndex]
            dataViewController.dataObject = self.tabs[self.tabNames[self.commentsTabIndex]]!
            return dataViewController
        case self.settingsTabIndex :
            dataViewController.currentTab = self.tabNames[self.commentsTabIndex]
            dataViewController.dataObject = self.tabs[self.tabNames[self.settingsTabIndex]]!
            return dataViewController
        default :
            return nil
        }
    }
    
    // MARK: - RGPageViewController Delegate
    // use this to set a custom height for the tabbar
    func heightForTabAtIndex(_ index: Int) -> CGFloat {
        return 120.0
    }
    
    // use this to set a custom width for a tab
    func widthForTabAtIndex(_ index: Int) -> CGFloat {
        var tabSize = self.tabNames[index].size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)])
        
        tabSize.width += 16
        
        return tabSize.width
        
    }
    
    // use this to change the height of the tab indicator
    func widthOrHeightForIndicator() -> CGFloat {
        return 2.0
    }
    override var pagerOrientation: UIPageViewControllerNavigationOrientation {
        get {
            return .horizontal
        }
    }
    
    override var tabbarPosition: RGTabbarPosition {
        get {
            return .top
        }
    }
    
    override var tabbarStyle: RGTabbarStyle {
        get {
            return .solid
        }
    }
    
    override var tabIndicatorColor: UIColor {
        get {
            return UIColor.init(red: 1, green: 204/255, blue: 204/255, alpha: 1)
        }
    }
    
    override var barTintColor: UIColor? {
        get {
            return self.navigationController?.navigationBar.barTintColor
        }
    }
    
    override var tabStyle: RGTabStyle {
        get {
            return .none
        }
    }
    
    override var tabbarWidth: CGFloat {
        get {
            return 140.0
        }
    }
    
    override var tabMargin: CGFloat {
        get {
            return 16.0
        }
    }
}
