//
//  League.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 22/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import Foundation

class League: CustomStringConvertible,CustomDebugStringConvertible {
    
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
    
    //description for getting more usefull data when printing the Model
    internal var description: String {
        return "<League:\"\(name)\">"
    }
    
    //debugDescription for getting more usefull data when using debugPrint  or po (printObject) in the console
    internal var debugDescription: String {
        return "<League:\(unsafeAddressOf(self)), \(name) img:\(imageName) id:\(identifier)>"
    }
}
