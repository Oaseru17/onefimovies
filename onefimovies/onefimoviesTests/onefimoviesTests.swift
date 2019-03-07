//
//  onefimoviesTests.swift
//  onefimoviesTests
//
//  Created by gHOST on 6/3/19.
//  Copyright © 2019 onefi. All rights reserved.
//
import XCTest
import Mockingjay
@testable import onefimovies

class onefimoviesTests: XCTestCase {
   
    override func setUp() {
    
        stub(everything, http(404))
        stub(uri("api/fialed"), http(500))
        let url = Bundle(for: type(of: self)).url(forResource: "sampleresponse", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        stub(everything, jsonData(data))
        
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
  
    func testURLSession() {
        let expectation = self.expectation(description: "NetworkTestingSession")
        
        let stubbedError = NSError(domain: "NetworkTestingSession", code: 0, userInfo: nil)
        stub(everything, failure(stubbedError))
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: URL(string: "/api/fialed")!, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }) .resume()
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error, String(describing: error))
        }
    }
    
    func testAssestsReading(){
        let resultingString = SeedManager.fetchString()
        XCTAssertNotNil(resultingString, "SeedManager not read the value in text file")
    }
    
    func testQueueCreation(){
        let testString = "Batman and Robin (1949)"
        let queue = SeedManager.converToQueue(seedData: testString)
        XCTAssertEqual(Double(queue.count), Double(1), accuracy: 0.000000001, "Converting into queue failed")
        
    }

    func testStringBoolExtensionForTrue(){
        let testString = "Yes"
    XCTAssertTrue(testString.bool!, "String to boolean must be true")
    }
    
    
    func testStringBoolExtensionForFalse(){
       let testString = "No"
          XCTAssertFalse(testString.bool!,"String to boolean must be false")
    }
    
    
    func testStringBoolExtensionForNil(){
         let testString = "Unknown"
         XCTAssertNil(testString.bool,"Should return nil")
    }
}
