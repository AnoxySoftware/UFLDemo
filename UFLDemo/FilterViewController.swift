//
//  FilterViewController.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 22/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    let reuseIdentifier = "leagueCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    var leagues = [League]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //create Mock Data
        self.createMockData()
        
        //reload CollectionView 
        self.collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension FilterViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.leagues.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseIdentifier, forIndexPath: indexPath) as! LeagueCVCell
        
        let league = leagues[indexPath.row]
        cell.setCellData(imageName:league.imageName, label: league.name)
        
        return cell
    }
}

extension FilterViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}

extension FilterViewController {
    
    func createMockData() {
        var league = League(name: NSLocalizedString("ALL\nLEAGUES", comment: "League Name"), imageName: "silver-icon", identifier: "All")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("SERIE A", comment: "League Name"), imageName: "Italy-Badge", identifier: "Italy")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("PREMIER\nLEAGUE", comment: "League Name"), imageName: "england", identifier: "Premier")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("LEAGUE 1", comment: "League Name"), imageName: "France-Contest", identifier: "France")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("SAUDI\nLEAGUE", comment: "League Name"), imageName: "saudi-contest", identifier: "Saudi")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("LA LIGA", comment: "League Name"), imageName: "Spain-Contest-Badge", identifier: "Spain")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("MLS", comment: "League Name"), imageName: "mls-contest", identifier: "USA")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("CHAMPIONS\nLEAGUE", comment: "League Name"), imageName: "champions-league-icon", identifier: "CHL")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("EUROPA\nLEAGUE", comment: "League Name"), imageName: "Europa-Contest", identifier: "Europa")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("EREDIVISIE", comment: "League Name"), imageName: "Dutch-contest-2", identifier: "Dutch")
        leagues.append(league)
    }
}
