//
//  Virtusa_IOS_Developer_AssignmentTests.swift
//  Virtusa-IOS-Developer-AssignmentTests
//
//  Created by Sachin Daingade on 13/04/22.
//

import XCTest
@testable import Virtusa_IOS_Developer_Assignment

class Virtusa_IOS_Developer_AssignmentTests: XCTestCase {
    let peopleViewModel = PeopleViewModel()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testGetPeople() throws {
        let expec = expectation(description: "test get people request")
        peopleViewModel.input.action.value =  .getPeoples
       
        peopleViewModel.output.requestState.next {[unowned self] state in
            switch state {
            case .idle,.none,.progress:
                break
            case .finished:
                print("Number of people: \(self.peopleViewModel.output.arrayOfPeople.value?.count ?? 0)")
                expec.fulfill()
            case .failWithError(let error):
                XCTFail(String(format: "fail to get people: \n %@", error.localizedDescription))
                expec.fulfill()
            }
        }
        waitForExpectations(timeout: 12.0) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testGetRoom() throws {
        let expec = expectation(description: "test get room request")
        peopleViewModel.input.action.value =  .getRooms
       
        peopleViewModel.output.requestState.next {[unowned self] state in
            switch state {
            case .idle,.none,.progress:
                break
            case .finished:
                print("Number of rooms: \(self.peopleViewModel.output.arrayOfRooms.value?.count ?? 0)")
                expec.fulfill()
            case .failWithError(let error):
                XCTFail(String(format: "fail to get rooms: \n %@", error.localizedDescription))
                expec.fulfill()
            }
        }
        waitForExpectations(timeout: 12.0) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
