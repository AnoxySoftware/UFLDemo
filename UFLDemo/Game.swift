//
//  Game.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 22/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import Foundation

enum GameTypes : Int {
    case bronze = 0xCD7F32
    case silver = 0xB3B1B1
    case gold = 0xFFD700
}

class Game: CustomStringConvertible,CustomDebugStringConvertible {

    var identifier: String
    var leagueId: String
    var gameType: GameTypes
    var gameDate: NSDate
    var homeTeam: Team
    var awayTeam: Team
    var homeTeamScore: UInt = 0
    var awayTeamScore: UInt = 0
    var isFinished: Bool = false
    let league: League
    
    init(homeTeam: Team, awayTeam: Team, gameDate: NSDate, gameType: GameTypes, league: League, identifier: String) {
        self.identifier = identifier
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.gameDate = gameDate
        self.gameType = gameType
        self.leagueId = league.identifier
        self.league = league
    }
    
    func setGameScore(home: UInt, away:UInt, completed:Bool) {
        self.homeTeamScore = home
        self.awayTeamScore = away
        self.isFinished = completed
    }
    
    //description for getting more usefull data when printing the Model
    internal var description: String {
        return "<Game:\"\(homeTeam)-\(awayTeam) Score:\(homeTeamScore)-\(awayTeamScore) League:\(leagueId)\">"
    }
    
    //debugDescription for getting more usefull data when using debugPrint or po (printObject) in the console
    internal var debugDescription: String {
        return "<Game:\(unsafeAddressOf(self)),\(homeTeam)-\(awayTeam) Score:\(homeTeamScore)-\(awayTeamScore) gameType:\(gameType) gameDate:\(gameDate) leagueId:\(leagueId) id:\(identifier)>"
    }
    
}
