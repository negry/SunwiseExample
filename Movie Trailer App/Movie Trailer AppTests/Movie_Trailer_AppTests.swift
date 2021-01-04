//
//  Movie_Trailer_AppTests.swift
//  Movie Trailer AppTests
//
//  Created by Alonso Fabian Orozco Perez on 28/12/20.
//

import XCTest

@testable import Movie_Trailer_App

//For this example mock not nedded
//class LoginInteractorInvalidCredentialsMock: LoginInteractorProtocol
//{
//    func requestLogin(username: String, password: String, completion: @escaping (Bool, LoginError?) -> Void) {
//        completion(false, LoginError.badCredentials)
//    }
//
//}

// For now just testing login (Happy & Sad Paths)
/**
 Username must be negryhtc@gmail.com & password = 123456 for happy path
 */
class Movie_Trailer_AppTests: XCTestCase {
    
    var loginInteractor: LoginInteractor?

    override func setUp() {
        super.setUp()
        self.loginInteractor = LoginInteractor()
    }
    
    override func tearDown() {
        self.loginInteractor = nil
        super.tearDown()
    }
    
    func testInvalidSignInCredentials()
    {
        self.loginInteractor!.requestLogin(username: "alonso@rocket.com", password: "alonso123") { (success, error: LoginError?) in
            XCTAssertFalse(success)
        }
    }
    
    func testValidSignInCredentials()
    {
        self.loginInteractor!.requestLogin(username: "negryhtc@gmail.com", password: "123456") { (success, error) in
            XCTAssert(success)
        }
    }

}
