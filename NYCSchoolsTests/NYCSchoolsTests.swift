//
//  NYCSchoolsTests.swift
//  NYCSchoolsTests
//

import XCTest
@testable import NYCSchools

class NYCSchoolsTests: XCTestCase {

    var networkManager: NetworkManager?
    var expectation: XCTestExpectation!
    var data: Data?
    
    override func setUpWithError() throws {
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        networkManager = NetworkManager(urlSession: urlSession)
        expectation = XCTestExpectation(description: "Expectation")
    }
    
    func testResponseSuccess() throws {

        MockURLProtocol.requestHandler = { [weak self] request in
            let response = HTTPURLResponse(url: Environment.schoolDirectoryURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, self?.data)
        }

        networkManager?.fetchData(url: Environment.schoolDirectoryURL) { (response: [School]?) in
            
            if response == nil {
                XCTFail("Error was not expected")
            } else {
                self.expectation?.fulfill()
            }
            
            self.expectation?.fulfill()
            self.wait(for: [self.expectation], timeout: 1.0)
        }
    }
    
    func testResponseFailed() {
        
        MockURLProtocol.requestHandler = { [weak self] request in
            let response = HTTPURLResponse(url: Environment.schoolDirectoryURL, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, self?.data)
        }
        
        networkManager?.fetchData(url: Environment.schoolDirectoryURL) { (response: [School]?) in
            
            if response == nil {
                self.expectation?.fulfill()
            } else {
                XCTFail("Success response was not expected.")
            }
            
            self.wait(for: [self.expectation], timeout: 1.0)
        }
    }
}
