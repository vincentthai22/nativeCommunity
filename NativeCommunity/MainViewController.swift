//
//  ViewController.swift
//  NativeCommunity
//
//  Created by Vincent on 12/28/16.
//  Copyright © 2016 Seven Logics. All rights reserved.
//

import UIKit

class MainViewController: RGPageViewController, RGPageViewControllerDataSource, RGPageViewControllerDelegate {
    
    /*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     * Data structure process: 1)Retrieve and store data     2) Determine when and which set of data to load.
     * Server call --> data array --> tabs dictionary --> repeat for each tab
     *
     * Retrieve and store data -- if "TOP" tab is the desired data to be loaded, load all posts into the "data" array then store this data into the "tabs" dictionary respective to its key, in this case its "TOP".
     * Determine which set of data -- The current pageIndex from viewControllerForPageIndex (current tab) will determine which set of data is to be loaded and which view to be displayed.
     *--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
     */
    
    // an array of dictionaries, each dictionary holds information related to post
    var data: [[String: AnyObject]] = []
    
    //Dictionary that holds a 2-D array of dictionaries respective to each tab.
    var tabs = ["TOP" : [[String : AnyObject]](), "NEW" : [[String : AnyObject]](), "PERIOD QUESTIONS" : [[String:AnyObject]](), "OFF-TOPIC" : [[String : AnyObject]]()]
    
    //tab names used to retrieve each array of dictionaries from the "tabs" dictionary.
    let tabNames = ["TOP", "NEW", "PERIOD QUESTIONS", "OFF-TOPIC"]
    
    let topTabIndex = 0, newTabIndex = 1, periodQuestionsTabIndex = 2, offTopicTabIndex = 3
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var askTheCommunityButton: UIButton!
    
    
    //Dummy data
    let testPost = ["question" : "Appreciation month GIFTS!", "description" : "Hello hello! So as we all know, November is appreciation month asdasdasd", "username" : "Rosalyn", "category" : "Ask the Community"]
    let testPost2 = ["question" : "Is it worth it?", "description" : "I've been on Lutera (BC pills) for about two months now af...", "username" : "girlboss", "category" : "Period Questions"]
    let testPost3 = ["question" : "How can I deal with anger?", "description" : "My family pisses me off. my mom is quite possibly the most asdasdasd","username" : "Gal", "category" : "Off-Topic"]
    let testPost4 = ["question" : "Cramping before period? Did you have implantation cramping before your periodasdasd", "description" : "I've been on Lutera (BC pills) for about two months now af...", "username" : "Nina", "category" : "Expecting Moms"]
    let testPost5 = ["question" : "Tampons. Um.", "description" : "Mabye this is a bit tmi but here goes. So my period just started...", "username" : "Eliza Hamilton", "category" : "Trending"]
    let testPost6 = ["question" : "blablablalblalbalbla", "description" : "lalalalalalala", "username" : "lala", "category" : "Off-Topic"]
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.currentTabIndex = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.currentTabIndex = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.datasource = self
        self.delegate = self
        self.data = [self.testPost as Dictionary<String, AnyObject>, self.testPost2 as Dictionary<String, AnyObject>, self.testPost3 as Dictionary<String, AnyObject>, self.testPost4 as Dictionary<String, AnyObject>, self.testPost5 as Dictionary<String, AnyObject>, self.testPost6 as Dictionary<String, AnyObject>]
        self.tabs["TOP"] = self.data
        self.view.bringSubview(toFront: self.askTheCommunityButton)
        setupNavBar()
        
    }
    
    func setupNavBar() -> Void {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 1, green: 204/255, blue: 204/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navItem.titleView?.tintColor = UIColor.white
        self.navItem.rightBarButtonItem = UIBarButtonItem.init(title: "profileImage", style: .plain, target: self, action: #selector(profileImageButtonHandler))
    }
    
    func profileImageButtonHandler() {
        
        print ("Profile image clicked")
        
    }
    
    @IBAction func askTheCommunityButtonActionHandler(_ sender: UIButton) {
        
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
       // dataViewController.view.frame = CGRect.init(x: 0, y: 164, width: 500, height: 600)// CGRect.init(x: 0, y: Int(self.heightForTabAtIndex(index)), width: self.view.frame.width, height: self.view.frame.height)
        switch (index) {
        case self.topTabIndex:
            dataViewController.dataObject = self.tabs["TOP"]
            break
        case self.newTabIndex:
            dataViewController.dataObject = self.tabs["NEW"]
            break
        case self.periodQuestionsTabIndex :
            dataViewController.dataObject = self.tabs["PERIOD QUESTIONS"]
            break
        case self.offTopicTabIndex :
            dataViewController.dataObject = self.tabs["OFF-TOPIC"]
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

