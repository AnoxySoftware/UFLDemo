//
//  GamesViewModelProtocol.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 24/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import Foundation

protocol GamePresentable {
    var homeTeam: String { get }
    var awayTeam: String { get }
    var homeTeamImageName: String { get }
    var awayTeamImageName: String { get }
    var score: String { get }
    var gameHexColor: Int { get }
    var gameTime: String { get }
    var gameFinished: Bool { get }
}

protocol HeaderPresentable {
    var dateString: String { get }
    var leagueTitle: String { get }
    var leagueImageName: String { get }
}
