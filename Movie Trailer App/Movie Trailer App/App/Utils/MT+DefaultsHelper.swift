//
//  MT+DefaultsHelper.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 29/12/20.
//

import Foundation

enum MTDefaultsKey : String
{
    case BEARER_TOKEN = "BEARER_TOKEN"
    case USER_EMAIL = "USER_EMAIL"
}

struct MTDefaultsHelper {
    
    static let shared = MTDefaultsHelper()
    
    private let userDefaults = UserDefaults.standard
    
    init()
    {
        self.setDefault(key: .BEARER_TOKEN, value: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NmNhYWYyNWM4M2Y0NDllYjFlMjkwMzVlZmQzMjc0OSIsInN1YiI6IjVmZWE5MDIxMGU2NGFmMDA0MGExODlmZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DUNuGxikPS9MUgeD7-xwnT-Y6Yp6gHNnBFxrRT_NLYE")
    }
    
    func setDefault(key: MTDefaultsKey, value: Any)
    {
        self.userDefaults.set(value, forKey: key.rawValue)
    }
    
    func getBoolValue(forKey key: MTDefaultsKey) -> Bool
    {
        return self.userDefaults.bool(forKey: key.rawValue)
    }
    
    func getString(key: MTDefaultsKey) -> String?
    {
        return self.userDefaults.string(forKey: key.rawValue)
    }
    
    func removeAll()
    {
        self.userDefaults.dictionaryRepresentation().forEach(
            {
                self.userDefaults.removeObject(forKey: $0.key)
        })
    }
    
}
