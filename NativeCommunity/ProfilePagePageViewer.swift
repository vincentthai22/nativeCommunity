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
    
    //Dictionary that holds a 2-D array of dictionaries respective to each tab.
    var tabs = ["PROFILE" : [[String : AnyObject]](), "POSTS" : [[String : AnyObject]](), "COMMENTS" : [[String:AnyObject]](), "SETTINGS" : [[String : AnyObject]]()]
    
    //tab names used to retrieve each array of dictionaries from the "tabs" dictionary.
    let tabNames = ["PROFILE", "POSTS", "COMMENTS", "SETTINGS"]
    
    let profileTabIndex = 0, postsTabIndex = 1, commentsTabIndex = 2, settingsTabIndex = 3
    
    //Dummy data
    let testPost = ["AboutMe" : "Appreciation month GIFTS!", "Birthday" : "Hello hello! So as we all know, November is appreciation month asdasdasd", "Location" : "Rosalyn", "Interests" : "Ask the Community"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datasource = self
        self.delegate = self
        self.data = [self.testPost as Dictionary<String, AnyObject>]
        self.tabs["PROFILE"] = self.data
    }
    
    
    // MARK: - RGPageViewController Data Source
    func numberOfPagesForViewController(_ pageViewController: RGPageViewController) -> Int {
        return tabNames.count
    }
    
    func tabViewForPageAtIndex(_ pageViewController: RGPageViewController, index: Int) -> UIView {
        var tabView: UIView!
        
        tabView = UILabel()
        
        (tabView as! UILabel).font = UIFont.systemFont(ofSize: 14)
        (tabView as! UILabel).text = tabNames[index]
        
        (tabView as! UILabel).sizeToFit()
        
        
        return tabView
    }
    
    
    func viewControllerForPageAtIndex(_ pageViewController: RGPageViewController, index: Int) -> UIViewController? {
        if (data.count == 0) || (index >= data.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let dataViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfilePageTableViewController") as! ProfilePageTableViewController
        switch (index) {
        case self.profileTabIndex:
            dataViewController.dataObject = self.tabs["PROFILE"]
            break
        case self.postsTabIndex:
            dataViewController.dataObject = self.tabs["POSTS"]
            break
        case self.commentsTabIndex :
            dataViewController.dataObject = self.tabs["COMMENTS"]
            break
        case self.settingsTabIndex :
            dataViewController.dataObject = self.tabs["SETTINGS"]
            break
        default :
            break
        }
        return dataViewController
    }
    
    // MARK: - RGPageViewController Delegate
    // use this to set a custom height for the tabbar
    func heightForTabAtIndex(_ index: Int) -> CGFloat {
        return 164.0
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
            return UIColor.black
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
