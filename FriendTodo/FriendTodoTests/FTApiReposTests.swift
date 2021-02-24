//
//  FTApiReposTests.swift
//  FriendTodoTests
//
//  Created by Andrea Bozza on 24/02/2021.
//

import XCTest
@testable import FriendTodo

class FTApiReposTests: XCTestCase {

    class MockURLSession: URLSession {
      var cachedUrl: URL?
      override func dataTask(with url: URL, completionHandler:      @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.cachedUrl = url
        
        return URLSessionDataTask()
      }
    }
    
    func testGetFriendsWithExpectedURLHostAndPath() {
      let apiRespository = FTApiRepo()
      let mockURLSession  = MockURLSession()
      apiRespository.session = mockURLSession
      apiRespository.getFriends() { friends, error in }
      XCTAssertEqual(mockURLSession.cachedUrl?.host, "jsonplaceholder.typicode.com")
      XCTAssertEqual(mockURLSession.cachedUrl?.path, "/users")
    }
    
    
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

}
