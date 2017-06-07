//
//  MockDataCreator.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 23/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import Foundation

enum MockDataCreatorError : ErrorType {
    case RuntimeError(String)
}

class MockDataCreator : NSObject {
    
    var leagues = [League]()
    var games = [Game]()
    var mockDataPlist : String
    
    init(mockDataPlist:String = "Teams", bundle:NSBundle = NSBundle.mainBundle()) {
        self.mockDataPlist = mockDataPlist
        super.init()
        self.createMockData(bundle)
    }
    
    private func createMockData(bundle:NSBundle) {
        var i = 0
        
        let league = League(name: NSLocalizedString("ALL LEAGUES", comment: "League Name"), imageName: "silver-icon", identifier: "All")
        leagues.append(league)
        
        if let path = bundle.pathForResource(self.mockDataPlist, ofType: "plist"), leagueData = NSArray(contentsOfFile: path) as? [NSDictionary] {
            for leagueDict in leagueData {
                
                let leagueName = leagueDict.valueForKey("name") as! String
                let leagueImageName = leagueDict.valueForKey("imageName") as! String
                let leagueId = leagueDict.valueForKey("identifier") as! String
                let teams = leagueDict.valueForKey("Teams") as! NSArray
                
                let league = League(name: NSLocalizedString(leagueName, comment: "League Name"), imageName: leagueImageName, identifier: leagueId)
                leagues.append(league)
                
                for teamName in teams {
                    let team = Team(name: teamName as! String, imageName: teamName as! String, identifier: leagueId+"_"+teamName.stringByReplacingOccurrencesOfString(" ", withString:""))
                    league.addTeam(team)
                }
                
                let date = NSDate.init(timeIntervalSinceNow: (Double(i) * 60 * 60.0))
                self.createMockGamesForLeague(leagueId,date:date)
                
                //advance date to 3 hours ahead for next league
                i += 3
            }
        }
    }

    private func createMockGamesForLeague(leagueId:String,date:NSDate) {
        //create some games for the league ...
        guard let league = getLeagueForIdentifier(leagueId) else {
            return
        }
        
        let gameTypes : [GameTypes] = [.bronze,.gold,.silver]
        
        var leagueTeams = league.teams
        let maxCount = (leagueTeams.count/2) - 1
        
        for i in 0...maxCount {
            //pick 2 teams from the league randomly
            let rnd1 = Int(arc4random_uniform(UInt32(leagueTeams.count)))
            let homeTeam = leagueTeams[rnd1]
            leagueTeams.removeAtIndex(rnd1)
            
            let rnd2 = Int(arc4random_uniform(UInt32(leagueTeams.count)))
            let awayTeam = leagueTeams[rnd2]
            leagueTeams.removeAtIndex(rnd2)
            
            //pick random gameType
            let rand = arc4random_uniform(UInt32(gameTypes.count))
            
            let game = Game(homeTeam: homeTeam, awayTeam: awayTeam, gameDate: date, gameType:gameTypes[Int(rand)], league: league, identifier: "\(leagueId)_\(i)")
            games.append(game)
            
        }
    }
    
    private func getLeagueForIdentifier(leagueId:String) -> League? {
        let matchingLeagues = self.leagues.filter {
            return $0.identifier == leagueId
        }
        return matchingLeagues.first
    }

}
