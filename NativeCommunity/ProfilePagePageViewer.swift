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
    var profileTab = [String:AnyObject]()
    //tab names used to retrieve each array of dictionaries from the "tabs" dictionary.
    let tabNames = ["PROFILE", "POSTS", "COMMENTS", "SETTINGS"]
    
    let profileTabIndex = 0, postsTabIndex = 1, commentsTabIndex = 2, settingsTabIndex = 3
    
    //Dummy data
    let testProfileData = ["About Me" : "Hi I'm Jilian and my favorite thing in the world is to dance", "Birthday" : "Oct 17, 1993 (23)", "Location" : "San Marino, CA", "Interests" : "dancing, picnics, music"]
    let testPostsData = [[ "title" : "Is it worth it?", "description" : "I've been on Lutera (BC pills) for about two months now . . .", "time" : "2 mins ago in" , "category" : "Period Questions"], ["title" : "Should I be worred?", "description" : "Hello guys I am new to the period community but I thought", "time" : "3 weeks ago in" , "category" : "Period Questions"], ["title" : "Cramping before period? Did you have implantation cramping before your period?", "description" : " ", "time" : "8 months ago" , "category" : "Period Questions"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datasource = self
        self.delegate = self
        self.data = [self.testProfileData as Dictionary<String, AnyObject>]
        self.profileTab = self.testProfileData as [String : AnyObject]
        self.tabs[self.tabNames[profileTabIndex]] = self.data
        self.tabs[self.tabNames[postsTabIndex]] = self.testPostsData as [[String : AnyObject]]?
        self.tabbar.frame = CGRect.init(x: 0, y: -3, width: view.bounds.width, height: self.tabbarHeight)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.currentTabIndex = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.currentTabIndex = 1
    }
    // MARK: - RGPageViewController Data Source
    func numberOfPagesForViewController(_ pageViewController: RGPageViewController) -> Int {
        return self.tabNames.count
    }
    
    func tabViewForPageAtIndex(_ pageViewController: RGPageViewController, index: Int) -> UIView {
        var tabView: UIView!
        
        tabView = UILabel()
        
        (tabView as! UILabel).font = UIFont.systemFont(ofSize: 14)
        (tabView as! UILabel).text = self.tabNames[index]
        (tabView as! UILabel).textColor = UIColor.init(red: 1, green: 204/255, blue: 204/255, alpha: 1)
        
        (tabView as! UILabel).sizeToFit()
        
        print ("index \(index)")
        
        return tabView
    }
    
    
    func viewControllerForPageAtIndex(_ pageViewController: RGPageViewController, index: Int) -> UIViewController? {
        if (self.tabNames.count == 0) || (index >= self.tabNames.count) {
            print ("index is \(index)")
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let dataViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfilePageTableViewController") as! ProfilePageTableViewController
        switch (index) {
        case self.profileTabIndex:
            dataViewController.currentTab = self.tabNames[self.profileTabIndex]
            dataViewController.profileDataObject = self.profileTab
            break
        case self.postsTabIndex:
            dataViewController.currentTab = self.tabNames[self.postsTabIndex]
            dataViewController.dataObject = self.tabs["POSTS"]!
            break
        case self.commentsTabIndex :
            dataViewController.currentTab = self.tabNames[self.commentsTabIndex]
            dataViewController.dataObject = self.tabs["COMMENTS"]!
            break
        case self.settingsTabIndex :
            dataViewController.currentTab = self.tabNames[self.commentsTabIndex]
            dataViewController.dataObject = self.tabs["SETTINGS"]!
            break
        default :
            break
        }
        return dataViewController
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
