//
//  ViewController.swift
//  NativeCommunity
//
//  Created by Vincent on 12/28/16.
//  Copyright © 2016 Seven Logics. All rights reserved.
//

import UIKit

class MainViewController: RGPageViewController, RGPageViewControllerDataSource, RGPageViewControllerDelegate {
    
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
    var data = [[String: AnyObject]]()
    
    //Dictionary that holds a 2-D array of dictionaries respective to each tab.
    var tabs = ["TOP" : [[String : AnyObject]](), "NEW" : [[String : AnyObject]](), "PERIOD QUESTIONS" : [[String:AnyObject]](), "OFF-TOPIC" : [[String : AnyObject]]()]
    
    //tab names used to retrieve each array of dictionaries from the "tabs" dictionary.
    let tabNames = ["TOP", "NEW", "PERIOD QUESTIONS", "OFF-TOPIC"]
    
    let topTabIndex = 0, newTabIndex = 1, periodQuestionsTabIndex = 2, offTopicTabIndex = 3
    
    var askTheCommunityButtonn :UIButton?
    
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var askTheCommunityButton: UIButton!
    
    
    
    
    //Dummy data
    let testPosts = [["question" : "Appreciation month GIFTS!", "description" : "Hello hello! So as we all know, November is appreciation month asdasdasd", "username" : "Rosalyn", "category" : "Ask the Community"],["question" : "Is it worth it?", "description" : "I've been on Lutera (BC pills) for about two months now af...", "username" : "girlboss", "category" : "Period Questions"],["question" : "How can I deal with anger?", "description" : "My family pisses me off. my mom is quite possibly the most asdasdasd","username" : "Gal", "category" : "Off-Topic"],["question" : "Cramping before period? Did you have implantation cramping before your periodasdasd", "description" : "I've been on Lutera (BC pills) for about two months now af...", "username" : "Nina", "category" : "Expecting Moms"], ["question" : "Tampons. Um.", "description" : "Mabye this is a bit tmi but here goes. So my period just started...", "username" : "Elizabeth", "category" : "Trending"],["question" : "blablablalblalbalbla", "description" : "lalalalalalala", "username" : "lala", "category" : "Off-Topic"],["question" : "Appreciation month GIFTS!", "description" : "Hello hello! So as we all know, November is appreciation month asdasdasd", "username" : "Rosalyn", "category" : "Ask the Community"],["question" : "Is it worth it?", "description" : "I've been on Lutera (BC pills) for about two months now af...", "username" : "girlboss", "category" : "Period Questions"],["question" : "How can I deal with anger?", "description" : "My family pisses me off. my mom is quite possibly the most asdasdasd","username" : "Gal", "category" : "Off-Topic"],["question" : "Cramping before period? Did you have implantation cramping before your periodasdasd", "description" : "I've been on Lutera (BC pills) for about two months now af...", "username" : "Nina", "category" : "Expecting Moms"], ["question" : "Tampons. Um.", "description" : "Mabye this is a bit tmi but here goes. So my period just started...", "username" : "Elizabeth", "category" : "Trending"],["question" : "blablablalblalbalbla", "description" : "lalalalalalala", "username" : "lala", "category" : "Off-Topic"]]
    
    
    let profileData = ["username" : "Jillian.99", "posts" : "240", "title" : "Little Gardener"]
    
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
        self.data = self.testPosts as [[String : AnyObject]]
        self.tabs["TOP"] = self.data
        self.view.bringSubview(toFront: self.askTheCommunityButton)
       //self.askTheCommunityButton.addTarget(self, action: #selector(askTheCommunityButtonHandler), for: UIControlEvents.touchUpInside)
        
        setupNavBar()
        
    }
    @IBAction func askTheCommunityButton(_ sender: UIButton) {
        print("yes")    
    }
    
    func setupNavBar() -> Void {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 1, green: 153/255, blue: 204/255, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navItem.titleView?.tintColor = UIColor.white
        self.navItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "person_icon_small"), style: .plain, target: self, action: #selector(profileImageButtonHandler))
    }
    
    func profileImageButtonHandler() {
        let transition = CATransition.init()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        transition.type = kCATransitionFromRight
        self.navigationController?.view.layer.add(transition, forKey: nil)
        print ("Profile image clicked")
        let nextViewController = self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        nextViewController.profileData = self.profileData as [String : AnyObject]
        nextViewController.navController = self.navigationController
        //nextViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(nextViewController, animated: true, completion: nil)
        //self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
//    @IBAction func askTheCommunityButtonActionHandler(_ sender: UIButton) {
//        let nextViewController = self.storyboard!.instantiateViewController(withIdentifier: "AskTheCommunityViewController") as! AskTheCommunityViewController
//        self.present(nextViewController, animated: true, completion: nil)
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - RGPageViewController Data Source
    func numberOfPagesForViewController(_ pageViewController: RGPageViewController) -> Int {
        return self.tabNames.count
    }
    
    func tabViewForPageAtIndex(_ pageViewController: RGPageViewController, index: Int) -> UIView {
        var tabView : UILabel?
        
            tabView = UILabel.init()
            
            tabView?.font = UIFont.systemFont(ofSize: 14)
            tabView?.text = self.tabNames[index]
            tabView?.textColor = UIColor.init(red: 1, green: 153/255, blue: 204/255, alpha: 1)
            tabView?.sizeToFit()
        
        
        return tabView!
    }
    
    
    func viewControllerForPageAtIndex(_ pageViewController: RGPageViewController, index: Int) -> UIViewController? {
        if (data.count == 0) || (index >= data.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let dataViewController = self.storyboard!.instantiateViewController(withIdentifier: "CommunityFrontPageTableViewController") as! CommunityFrontPageTableViewController
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

