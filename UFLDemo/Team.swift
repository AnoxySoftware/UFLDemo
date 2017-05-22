//
//  Team.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 22/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import Foundation

class Team: NSObject {
    
    let identifier: String
    let name: String
    let imageName: String
    
    init(name: String, imageName: String, identifier: String) {
        self.name = name
        self.imageName = imageName
        self.identifier = identifier
    }
}
