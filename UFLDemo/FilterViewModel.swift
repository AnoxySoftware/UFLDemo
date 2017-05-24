//
//  FilterViewModel.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 24/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import Foundation

class FilterViewModel : NSObject {
    
    struct LeagueViewModel: HeaderPresentable {
        
        let dateString: String
        var leagueTitle: String
        var leagueImageName: String
        
        init(withLeague league: League) {
            self.dateString = ""
            self.leagueTitle = league.name
            self.leagueImageName = league.imageName
        }
    }
    
    private var leagues = [League]()
    
    init(mockLeagues:[League]) {
        super.init()
        self.leagues = mockLeagues
    }
    
    //returns the number of items in the section
    func numberOfItemsInSection(section:Int) -> Int {
        return leagues.count
    }
    
    func dataForIndexPath(indexPath:NSIndexPath) -> HeaderPresentable {
        return LeagueViewModel(withLeague: leagues[indexPath.row])
    }
    
    func getLeagueIdForIndexPath(indexPath:NSIndexPath) -> String {
        let league = leagues[indexPath.row]
        return league.identifier
    }
}

