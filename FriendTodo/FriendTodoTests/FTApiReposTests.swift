//
//  FTApiReposTests.swift
//  FriendTodoTests
//
//  Created by Andrea Bozza on 24/02/2021.
//

import XCTest
@testable import FriendTodo

class MockTask: URLSessionDataTask {
    private let data: Data?
    private let urlResponse: URLResponse?
    private let _error: Error?
    override var error: Error? {
        return _error
    }
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)!
    
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self._error = error
    }
    override func resume() {
        DispatchQueue.main.async {
            self.completionHandler(self.data, self.urlResponse, self.error)
        }
    }
}

class MockURLSession: URLSession {
    var cachedUrl: URL?
    private let mockTask: MockTask
    init(data: Data?, urlResponse: URLResponse?, error: Error?) {
        mockTask = MockTask(data: data, urlResponse: urlResponse, error:
                                error)
    }
    override func dataTask(with url: URL, completionHandler:      @escaping(Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.cachedUrl = url
        mockTask.completionHandler = completionHandler
        return mockTask
    }
}


class FTApiReposTests: XCTestCase {
    
    /**
     Get Users From API Sets up URL Host and Path as Expected
     */
    
    func testGetFriendsWithExpectedURLHostAndPath() {
        let apiRespository = FTApiRepo()
        let mockURLSession  = MockURLSession(data: nil, urlResponse: nil, error: nil)
        apiRespository.session = mockURLSession
        apiRespository.getFriends() { friends, error in }
        XCTAssertEqual(mockURLSession.cachedUrl?.host, "jsonplaceholder.typicode.com")
        XCTAssertEqual(mockURLSession.cachedUrl?.path, "/users")
    }
    
    /**
     Get Users From API Successfully Returns List of Friend
     */
    
    func testGetFriendsSuccessReturnsFriends() {
        let jsonData = "[{\"name\": \"Andrea\",\"username\": \"abozza\"}]".data(using: .utf8)
        let apiRespository = FTApiRepo()
        let mockURLSession  = MockURLSession(data: jsonData, urlResponse: nil, error: nil)
        apiRespository.session = mockURLSession
        let friendsExpectation = expectation(description: "friends")
        var friendsResponse: [Friend]?
        
        apiRespository.getFriends { (friends, error) in
            friendsResponse = friends
            friendsExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNotNil(friendsResponse)
        }
    }
    
    /**
     Get Users From API Fails and  Returns error
     */
    
    func testGetMoviesWhenResponseErrorReturnsError() {
      let apiRespository = FTApiRepo()
      let error = NSError(domain: "error", code: 1234, userInfo: nil)
      let mockURLSession  = MockURLSession(data: nil, urlResponse: nil, error: error)
      apiRespository.session = mockURLSession
      let errorExpectation = expectation(description: "error")
      var errorResponse: Error?
        apiRespository.getFriends { (friends, error) in
        errorResponse = error
        errorExpectation.fulfill()
      }
      waitForExpectations(timeout: 1) { (error) in
        XCTAssertNotNil(errorResponse)
      }
    }
    
    /**
     Get Users From API Fails and  Returns error
     */
    
    func testGetMoviesWhenEmptyDataReturnsError() {
      let apiRespository = FTApiRepo()
      let mockURLSession  = MockURLSession(data: nil, urlResponse: nil, error: nil)
      apiRespository.session = mockURLSession
      let errorExpectation = expectation(description: "error")
      var errorResponse: Error?
      apiRespository.getFriends { (friends, error) in
        errorResponse = error
        errorExpectation.fulfill()
      }
      waitForExpectations(timeout: 1) { (error) in
        XCTAssertNotNil(errorResponse)
      }
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
