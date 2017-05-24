//
//  ViewController.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 22/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let headerHeight : CGFloat = 70
    let reuseIdentifier = "gameCell"

    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterBtnItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: GamesViewModel?
    var filterBarVisible = false
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.btnSelectedColor
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), forControlEvents: UIControlEvents.ValueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let mockData = MockDataCreator()
        viewModel = GamesViewModel.init(mockGames: mockData.games)
        
        self.tableView.addSubview(refreshControl)
        self.tableView.reloadData()
        addKVO()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        subscribeToNotifications()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromNotifications()
    }
    
    deinit {
        removeKVO()
    }
    
    // MARK: Notifications
    private func subscribeToNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(filterDidChangeNotification(_:)),
            name: FilterViewNotifications.FilterDidChangeNotification,
            object: nil)
    }
    
    private func unsubscribeFromNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func filterDidChangeNotification(notification: NSNotification) {
        guard let leagueId = notification.userInfo![FilterViewNotificationLeagueKey], let viewModel = viewModel  else { return }
        //filter leagues based on the league Id
        viewModel.filterGamesWithLeagueId(leagueId as! String)
        //hide the bar
        self.toggleFilterBar(filterBtnItem)
        self.tableView.setContentOffset(CGPointZero, animated:false)
    }
    
    //MARK: KVO
    private func addKVO() {
        guard let viewModel = viewModel else {return}
        viewModel.addObserver(self, forKeyPath: "needsRefresh", options: .New, context: nil)
    }
    
    private func removeKVO() {
        guard let viewModel = viewModel else {return}
        viewModel.removeObserver(self, forKeyPath: "needsRefresh", context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "needsRefresh" {
            reloadDataAnimated()
        } else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    // MARK: Actions
    @IBAction func toggleFilterBar(sender: AnyObject) {
        filterBarVisible = !filterBarVisible
        
        if let button: UIBarButtonItem = sender as? UIBarButtonItem {
            button.tintColor = filterBarVisible ? UIColor.btnSelectedColor : UIColor.whiteColor()
        }
        
        //animate the filter bar (the extra 5 pixels in the filterView height are for the drop shadow)
        UIView.animateWithDuration(0.4,
                                   delay: 0,
                                   options:.CurveEaseOut,
                                   animations: {
                                    self.filterTopConstraint.constant = self.filterBarVisible ? 0 : -(self.filterView.frame.size.height+5)
                                    self.view.layoutIfNeeded()
                                   },
                                   completion: nil)
    }
    
    func refreshData(refreshControl: UIRefreshControl) {
        guard let viewModel = viewModel else {return}
        
        //add fake 2 secs delay to simulate network fetch
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            viewModel.refreshData()
        }
    }
    
    private func reloadDataAnimated() {
        
        if (refreshControl.refreshing) {
            refreshControl.endRefreshing()
        }
        
        UIView.transitionWithView(self.tableView,
                                  duration: 0.45,
                                  options: .TransitionCrossDissolve,
                                  animations: {
                                    self.tableView.reloadData()
            },
                                  completion: nil);
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let viewModel = viewModel else {return 0}
        return viewModel.numberOfSections()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {return 0}
        return viewModel.numberOfItemsInSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! GameTVCell
        
        if let viewModel = viewModel {
            cell.configure(withPresenter: viewModel.gameViewModelForIndexPath(indexPath))
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let viewModel = viewModel else {return 0}
        
        if viewModel.headerTypeForSection(section) == HeaderTypes.doubleWithDate {
            return headerHeight
        }
        
        return headerHeight / 2
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel else {return nil}
        let header = headerView()
        header.configure(withPresenter: viewModel.headerDataForSection(section))
        return header
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
