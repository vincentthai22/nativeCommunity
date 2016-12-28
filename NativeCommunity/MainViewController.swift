//
//  ViewController.swift
//  NativeCommunity
//
//  Created by Vincent on 12/28/16.
//  Copyright © 2016 Seven Logics. All rights reserved.
//

import UIKit

class MainViewController: RGPageViewController, RGPageViewControllerDataSource, RGPageViewControllerDelegate {
    
    // 2-D an array of dictionaries, each dictionary holds information related to post
    var data: [[String: AnyObject]] = []
    //Dictionary that holds a 2-D array of dictionaries respective to each tab.
    var tabs = ["TOP" : [[String : AnyObject]](), "NEW" : [[String : AnyObject]](), "PERIOD QUESTIONS" : [[String:AnyObject]]()]
    //tab names
    let tabNames = ["TOP", "NEW", "PERIOD QUESTIONS", "OFF-TOPIC"]
    let post1 = [String : String]()
    
    //Dummy variables
    let testPost = ["question" : "Is it worth it?", "description" : "I've been on Lutera (BC pills) for about two months now af...", "username" : "Rosalyn", "category" : "Ask the Community"]
    let testPost2 = ["question" : "Is it worth it?", "description" : "I've been on Lutera (BC pills) for about two months now af...", "username" : "girlboss", "category" : "Period Questions"]
    let testPost3 = ["question" : "Is it worth it?", "description" : "I've been on Lutera (BC pills) for about two months now af...","username" : "Gal", "category" : "Off-Topic"]
    let testPost4 = ["question" : "Is it worth it?", "description" : "I've been on Lutera (BC pills) for about two months now af...", "username" : "Nina", "category" : "Expecting Moms"]
    let testPost5 = ["question" : "Is it worth it?", "description" : "I've been on Lutera (BC pills) for about two months now af...", "username" : "Eliza Hamilton", "category" : "Trending"]
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.currentTabIndex = 3
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.currentTabIndex = 3
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.data = [self.testPost as Dictionary<String, AnyObject>, self.testPost2 as Dictionary<String, AnyObject>, self.testPost3 as Dictionary<String, AnyObject>, self.testPost4 as Dictionary<String, AnyObject>, self.testPost5 as Dictionary<String, AnyObject>]
        self.tabs["TOP"] = self.data
        self.datasource = self
        self.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func reloadPager(_ sender: UIBarButtonItem) {
        reloadData()
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
        let dataViewController = storyboard!.instantiateViewController(withIdentifier: "DataTableViewController") as! DataTableViewController
        
        
        dataViewController.dataObject = self.tabs["TOP"]
        
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
            
        tabSize.width += 32
            
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
            return .blurred
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
            return .inactiveFaded
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

