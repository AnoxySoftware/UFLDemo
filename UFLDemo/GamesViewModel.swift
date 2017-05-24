//
//  GamesViewModel.swift
//  UFLDemo
//
//  Created by Eleftherios Charitou on 23/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import Foundation

enum HeaderTypes {
    case doubleWithDate
    case single
}

class GamesViewModel : NSObject {

    private class SectionInfo: CustomStringConvertible,CustomDebugStringConvertible,HeaderPresentable {
        
        let dateString : String
        let headerType : HeaderTypes
        let leagueId : String
        var leagueTitle : String
        var leagueImageName : String
        var sectionGames : [Game]
        
        init(dateString: String, leagueId: String, headerType:HeaderTypes) {
            self.dateString = dateString
            self.headerType = headerType
            self.leagueId = leagueId
            self.leagueTitle = ""
            self.leagueImageName = ""
            self.sectionGames = [Game]()
        }
        
        //description for getting more usefull data when printing the Model
        private var description: String {
            return "<Section:\"\(dateString), \(leagueTitle) Games:\(sectionGames)\">"
        }
        
        //debugDescription for getting more usefull data when using debugPrint or po (printObject) in the console
        private var debugDescription: String {
            return "<Section:\"\(unsafeAddressOf(self)), \(dateString), \(leagueTitle) headerType:\(headerType)\">"
        }
    }
    
    //our array holding our games list
    private var sectionData = [SectionInfo]()
    private var filteredSectionData = [SectionInfo]()
    
    //KVO for updating our View
    dynamic var needsRefresh = false
    
    override init() {
        super.init()
        let mockData = MockDataCreator()
        createSectionData(mockData.games)
    }
    
    //returns the number of sections for our TableView
    func numberOfSections() -> Int {
        return filteredSectionData.count
    }
    
    //returns the number of items in the section
    func numberOfItemsInSection(section:Int) -> Int {
        let section = filteredSectionData[section]
        return section.sectionGames.count
    }
    
    //gets the type of the header for the section (single, or double with date)
    func headerTypeForSection(section:Int) -> HeaderTypes {
        let section = filteredSectionData[section]
        return section.headerType
    }
    
    func headerDataForSection(section:Int) -> HeaderPresentable {
        let section = filteredSectionData[section]
        return section
    }
    
    //provides the SingleGameViewModel struct for populating the cell of our TableView
    func gameViewModelForIndexPath(indexPath:NSIndexPath) -> SingleGameViewModel {
        let section = filteredSectionData[indexPath.section]
        let game = section.sectionGames[indexPath.row]
        
        let gameVM = SingleGameViewModel.init(withGame: game)
        return gameVM
    }
    
    //create sectionData
    private func createSectionData(games:[Game]) {
        //clear old data (in case we refresh)
        self.sectionData.removeAll()
        
        //first sort games by date (asuming this won't be necessary if we get from backend sorted data)
        let games = games.sort({$0.gameDate.compare($1.gameDate) == NSComparisonResult.OrderedAscending})
        
        //NOTE:assuming data are grouped in leagues (it is already in our mockdata and assuming it will be same from backend)
        
        //iterrate over games and add them in the sections...
        var previousDay = 0
        var section : SectionInfo?
        var previousLeaugeId = ""
        
        for game in games {
            let gameDay = game.gameDate.day

            if (gameDay != previousDay) {
                previousDay = gameDay
                if let existingSection = section {
                    sectionData.append(existingSection)
                }
                //start a new day...
                section = SectionInfo(dateString: getFormattedDayFromDate(game.gameDate), leagueId: game.leagueId, headerType:.doubleWithDate)
            }
            
            //check the game league id
            //if it's not the same as the previous we need to create a new section
            if (previousLeaugeId != game.leagueId) {
                previousLeaugeId = game.leagueId
                
                //we force unwrap the section optional as it must exist here, if it doesn't we should crash, as it will be a logical error
                //check if the previous section has games already or if it's the first one (just has day and no games yet)
                if (section!.sectionGames.count>0) {
                    //add the previous section to our array
                    sectionData.append(section!)
                    //create a new section with single header
                    section = SectionInfo(dateString: "", leagueId: game.leagueId, headerType:.single)
                }
                
                section!.leagueTitle = game.league.name
                section!.leagueImageName = game.league.imageName
                
            }
            
            //add the game to the correct section now
            section!.sectionGames.append(game)
        }
        
        //add the last section to our array
        if let section = section {
            sectionData.append(section)
        }
        
        filteredSectionData = sectionData
    }
    
    func filterGamesWithLeagueId(leagueId:String) {
        if (leagueId == "All") {
            filteredSectionData = sectionData
        }
        else {
            filteredSectionData = sectionData.filter({$0.leagueId == leagueId})
        }
        
        //change the value so our KVO can pick it up and refresh table
        needsRefresh = !needsRefresh
    }
    
    func refreshData() {
        let mockData = MockDataCreator()
        createSectionData(mockData.games)
        
        //change the value so our KVO can pick it up and refresh table
        needsRefresh = !needsRefresh
    }
    
    private func getFormattedDayFromDate(date:NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EdMMM")
        let timeString = formatter.stringFromDate(date)
        return timeString
    }
    
}

struct SingleGameViewModel: GamePresentable {
    
    let homeTeam: String
    let awayTeam: String
    let homeTeamImageName: String
    let awayTeamImageName: String
    let score: String
    let gameHexColor: Int
    let gameTime: String
    let gameFinished: Bool
    
    init(withGame game: Game) {
        self.homeTeam = game.homeTeam.name
        self.awayTeam = game.awayTeam.name
        self.homeTeamImageName = game.homeTeam.imageName
        self.awayTeamImageName = game.awayTeam.imageName
        self.score = "\(game.homeTeamScore) - \(game.awayTeamScore)"
        self.gameHexColor = game.gameType.rawValue
        self.gameTime = SingleGameViewModel.getTimeFromDate(game.gameDate)
        self.gameFinished = game.isFinished
    }
    
    static func getTimeFromDate(date:NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeString = formatter.stringFromDate(date)
        return timeString
    }
}
