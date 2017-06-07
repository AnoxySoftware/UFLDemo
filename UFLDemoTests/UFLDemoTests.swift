//
//  UFLDemoTests.swift
//  UFLDemoTests
//
//  Created by Eleftherios Charitou on 24/05/17.
//  Copyright © 2017 Anoxy Software. All rights reserved.
//

import XCTest
@testable import UFLDemo

class UFLDemoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMockInit() {
        let mockData = MockDataCreator(mockDataPlist: "2League", bundle:NSBundle(forClass: self.dynamicType))
        let viewModel = GamesViewModel(mockGames: mockData.games)
        XCTAssertEqual(viewModel.numberOfSections(),2)
    }
    
    func testFilterLeague() {
        let mockData = MockDataCreator(mockDataPlist: "2League", bundle:NSBundle(forClass: self.dynamicType))
        let viewModel = GamesViewModel(mockGames: mockData.games)
        viewModel.filterGamesWithLeagueId("ita")
        //our viewmodel should now only contain 1 section and 2 games
        XCTAssertEqual(viewModel.numberOfSections(),1)
        XCTAssertEqual(viewModel.numberOfItemsInSection(0),2)
    }
    
    func testGameViewModel() {
        let mockData = MockDataCreator(mockDataPlist: "SingleGame", bundle:NSBundle(forClass: self.dynamicType))
        let viewModel = GamesViewModel(mockGames: mockData.games)
        
        let gameData = viewModel.gameViewModelForIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        
        //verify that the home or away team is chelsea or everton (can be either way as random picks are happening)
        XCTAssert(gameData.homeTeam.isEqual("Chelsea") || gameData.homeTeam.isEqual("Everton"))
        XCTAssert(gameData.awayTeam.isEqual("Chelsea") || gameData.awayTeam.isEqual("Everton"))
        XCTAssert(gameData.homeTeamImageName.isEqual("Chelsea") || gameData.homeTeamImageName.isEqual("Everton"))
        XCTAssert(gameData.awayTeamImageName.isEqual("Chelsea") || gameData.awayTeamImageName.isEqual("Everton"))
        
        XCTAssertEqual(gameData.score,"0 - 0")
        XCTAssertTrue(!gameData.gameFinished)
    }
    
    func testFilterViewModelCreation() {
        let mockData = MockDataCreator(mockDataPlist: "2League", bundle:NSBundle(forClass: self.dynamicType))
        let viewModel = FilterViewModel(mockLeagues:mockData.leagues)
        //league count should be 3, as we have 2 from the PLIST + 1 which is the ALL Leagues
        XCTAssertEqual(viewModel.numberOfItemsInSection(0),3)
    }
    
    func testFilterViewData() {
        let mockData = MockDataCreator(mockDataPlist: "2League", bundle:NSBundle(forClass: self.dynamicType))
        let viewModel = FilterViewModel(mockLeagues:mockData.leagues)
        let leagueData = viewModel.dataForIndexPath(NSIndexPath(forRow: 1, inSection: 0))
        
        XCTAssertEqual(leagueData.leagueTitle,"SERIE A")
        XCTAssertEqual(leagueData.leagueImageName,"Italy-Badge")
    }
    
    func testFilterViewLeagueIdentifier() {
        let mockData = MockDataCreator(mockDataPlist: "2League", bundle:NSBundle(forClass: self.dynamicType))
        let viewModel = FilterViewModel(mockLeagues:mockData.leagues)
        
        let leagueId = viewModel.getLeagueIdForIndexPath(NSIndexPath(forRow: 2, inSection: 0))
        //league should be england in our test
        
        XCTAssertEqual(leagueId,"eng")
    }
    
}
