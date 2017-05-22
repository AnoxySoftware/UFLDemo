//
//  League.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 22/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import Foundation

class League: NSObject {
    
    let identifier: String
    let name: String
    let imageName: String
    var teams: [Team]
    
    init(name: String, imageName: String, identifier: String) {
        self.name = name
        self.imageName = imageName
        self.identifier = identifier
        self.teams = []
    }
    
    func addTeam(team: Team) {
        self.teams.append(team)
    }
    
    func containsTeam(team: Team) -> Bool {
        return self.teams.contains { $0.identifier == team.identifier }
    }
}
