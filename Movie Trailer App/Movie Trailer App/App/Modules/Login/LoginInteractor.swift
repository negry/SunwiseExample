//
//  LoginInteractor.swift
//  Movie Trailer App
//
//  Created Alonso Fabian Orozco Perez on 28/12/20.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by ___ORGANIZATIONNAME___
//

import Foundation

enum LoginError: Error {
    case badCredentials
    
    var localizedDescription: String {
        switch self {
        case .badCredentials:
            return "Invalid username or password"
        }
    }
}

//MARK: Interactor protocol -
protocol LoginInteractorProtocol: class {
    func requestLogin(username: String, password: String, completion: @escaping (Bool, LoginError?) -> Void)
}

//MARK: Interactor implementation -
class LoginInteractor: LoginInteractorProtocol {
   
    func requestLogin(username: String, password: String, completion: @escaping (Bool, LoginError?) -> Void) {
        if username == "negryhtc@gmail.com" && password == "123456" {
            MTDefaultsHelper.shared.setDefault(key: .USER_EMAIL, value: username)
            completion(true, nil)
        }else {
            completion(false, .badCredentials)
        }
    }
}
