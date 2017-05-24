//
//  FilterViewController.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 22/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import UIKit

enum FilterViewNotifications {
    static let FilterDidChangeNotification = "FilterDidChangeNotification"
}

let FilterViewNotificationLeagueKey = "com.anoxy.leagueIdNotif"

class FilterViewController: UIViewController {
    let reuseIdentifier = "leagueCell"
    
    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: FilterViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let mockData = MockDataCreator()
        viewModel = FilterViewModel.init(mockLeagues: mockData.leagues)
        
        //reload collection view
        self.collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FilterViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseIdentifier, forIndexPath: indexPath) as! LeagueCVCell
        
        if let viewModel = viewModel {
            cell.configure(withPresenter: viewModel.dataForIndexPath(indexPath))
        }
        
        return cell
    }
}

extension FilterViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let viewModel = viewModel else { return }
        
        //highlight the selection and fire the notification....
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! LeagueCVCell
        cell.highLightCell()
        
        let leagueId = viewModel.getLeagueIdForIndexPath(indexPath)
        
        //we pass the league Identifier in the userInfo so we can filter out our data
        NSNotificationCenter.defaultCenter().postNotificationName(FilterViewNotifications.FilterDidChangeNotification, object: nil, userInfo:[FilterViewNotificationLeagueKey:leagueId])
        
        //dehighlight cell after 1 sec
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            cell.deHighLightCell()
        }
    }
}
