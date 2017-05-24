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
    
    override init() {
        super.init()
        self.createMockData()
    }
    
    private func createMockData() {
        self.createLeagueMockData()        
        self.createTeamsMockData()
    }
    
    private func createLeagueMockData() {
        
        var league = League(name: NSLocalizedString("ALL LEAGUES", comment: "League Name"), imageName: "silver-icon", identifier: "All")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("SERIE A", comment: "League Name"), imageName: "Italy-Badge", identifier: "ita")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("PREMIER LEAGUE", comment: "League Name"), imageName: "england", identifier: "eng")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("LEAGUE 1", comment: "League Name"), imageName: "France-Contest", identifier: "fra")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("SAUDI LEAGUE", comment: "League Name"), imageName: "saudi-contest", identifier: "saudi")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("LA LIGA", comment: "League Name"), imageName: "Spain-Contest-Badge", identifier: "esp")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("MLS", comment: "League Name"), imageName: "mls-contest", identifier: "mls")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("CHAMPIONS LEAGUE", comment: "League Name"), imageName: "champions-league-icon", identifier: "chl")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("EUROPA LEAGUE", comment: "League Name"), imageName: "Europa-Contest", identifier: "euroleague")
        leagues.append(league)
        
        league = League(name: NSLocalizedString("EREDIVISIE", comment: "League Name"), imageName: "Dutch-contest-2", identifier: "ned")
        leagues.append(league)
    }
    
    private func createTeamsMockData() {
        var i = 0
        
        if let path = NSBundle.mainBundle().pathForResource("Teams", ofType: "plist"), teamsDict = NSDictionary(contentsOfFile: path) as? [String:[String]] {
            for (leagueId, teams) in teamsDict {
                
                if let league = getLeagueForIdentifier(leagueId) {
                    
                    for teamName in teams {
                        let team = Team(name: teamName, imageName: teamName, identifier: leagueId+"_"+teamName.stringByReplacingOccurrencesOfString(" ", withString:""))
                        league.addTeam(team)
                    }
                    
                    let date = NSDate.init(timeIntervalSinceNow: (Double(i) * 60 * 60.0))
                    self.createMockGamesForLeague(leagueId,date:date)
                    
                    //advance date to 3 hours ahead for next league
                    i += 3
                }
            }
        }
    }

    private func createMockGamesForLeague(leagueId:String,date:NSDate) {
        //create some games for the league ...
        guard let league = getLeagueForIdentifier(leagueId) else {
            return
        }
        
        let gameTypes : [GameTypes] = [.bronze,.gold,.silver]
        
        for i in 0.stride(to:league.teams.count-1, by:2){
            //pick 2 teams from the league
            let homeTeam = league.teams[i]
            let awayTeam = league.teams[i+1]
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
