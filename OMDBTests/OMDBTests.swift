//
//  OMDBTests.swift
//  OMDBTests
//
//  Created by Kunal Tyagi on 30/09/18.
//  Copyright © 2018 Kunal Tyagi. All rights reserved.
//

import XCTest
@testable import OMDB

class OMDBTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testForBackgroundColor() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "homeVC") as? HomeVC
        let detailVC = storyboard.instantiateViewController(withIdentifier: "detailView") as? DetailVC
        XCTAssertEqual(homeVC?.view.backgroundColor, detailVC?.view.backgroundColor)
    }

}

