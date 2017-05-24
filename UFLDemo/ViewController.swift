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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewModel = GamesViewModel.init()
        self.tableView.reloadData()
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
    
    @objc private func filterDidChangeNotification(notification: NSNotification) {
        guard let leagueId = notification.userInfo![FilterViewNotificationLeagueKey], let viewModel = viewModel  else { return }
        //filter leagues based on the league Id
        viewModel.filterGamesWithLeagueId(leagueId as! String)
        //hide the bar
        self.toggleFilterBar(filterBtnItem)
        self.tableView.setContentOffset(CGPointZero, animated:false)
        //reload the tableview with a simple crossfade animation
        UIView.transitionWithView(self.tableView,
                                  duration: 0.45,
                                  options: .TransitionCrossDissolve,
                                  animations: {
                                    self.tableView.reloadData()
                                    },
                                  completion: nil);
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
