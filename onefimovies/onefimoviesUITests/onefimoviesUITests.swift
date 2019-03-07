//
//  onefimoviesUITests.swift
//  onefimoviesUITests
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//

import XCTest

class onefimoviesUITests: XCTestCase {
 var app: XCUIApplication!
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }

    override func tearDown() {
        databasehelper.reset()
    }
    func testGoingThroughOnboarding() {
        app.launch()
        XCTAssertTrue(app.buttons["nextBtn"].label == "Next","Showed be showing Next")
        app.swipeLeft()
        app.swipeLeft()
        app.buttons["nextBtn"].tap()
        XCTAssertFalse(app.buttons["nextBtn"].label == "Finish","Showed be showing Finish")
        
    }
    
    
    

}
