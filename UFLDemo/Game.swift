//
//  Game.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 22/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import Foundation

class Game: NSObject {

    var identifier: String
    var gameDate: NSDate
    var homeTeam: Team
    var awayTeam: Team
    var homeTeamScore: UInt = 0
    var awayTeamScore: UInt = 0
    var isFinished: Bool = false
    
    init(homeTeam: Team, awayTeam: Team, gameDate: NSDate, identifier: String) {
        self.identifier = identifier
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.gameDate = gameDate
    }
    
    func updateScore(score: UInt, withScoringTeam team: Team) {
        if isFinished || score == 0 {
            return
        }
        
        if homeTeam == team {
            homeTeamScore += score
        }
        else {
            assert(awayTeam == team)
            awayTeamScore += score
        }
    }
}
