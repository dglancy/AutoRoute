//
//  DrivelineUITests.swift
//  DrivelineUITests
//
//  Created by Damien Glancy on 30/05/2026.
//

import XCTest

final class DrivelineUITests: BaseXCTestCase {
  
  @MainActor
  func testNoDrivesEmptyScreen() throws {
    // Navigation title
    XCTAssertTrue(app.navigationBars["Drives"].waitForExistence(timeout: 5))
    
    // Empty state
    XCTAssertTrue(app.staticTexts["No Drives"].waitForExistence(timeout: 5))
    XCTAssertTrue(app.staticTexts["Your recorded drives will appear here."].exists)
    
    // Record button
    XCTAssertTrue(app.buttons["Start a new drive"].exists)
  }
  
  @MainActor
  func testRecordScreenFromEmptyScreen() throws {
    navigatePastEmptyState()
  }
  
}
  
  //// Assert text exists on screen
  //XCTAssertTrue(app.staticTexts["Your text here"].exists)
  //
  //// Assert a button exists
  //XCTAssertTrue(app.buttons["Button Label"].exists)
  //
  //// Wait for elements that may take time to appear
  //let button = app.buttons["Finish Drive"]
  //XCTAssertTrue(button.waitForExistence(timeout: 5))
  
  
  //func testLaunchEmpty() throws {
  //    app.launch()
  //
  //    // Assert the record button exists before tapping
  //    XCTAssertTrue(app.buttons["Start a new drive"].waitForExistence(timeout: 5))
  //    app.buttons["record.circle"].firstMatch.tap()
  //
  //    // Assert some label appears on the recording screen
  //    XCTAssertTrue(app.staticTexts["Recording"].waitForExistence(timeout: 5))
  //
  //    app.buttons["stop.fill"].firstMatch.tap()
  //}
