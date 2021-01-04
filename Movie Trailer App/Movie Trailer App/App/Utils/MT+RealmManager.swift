//
//  MT+RealmManager.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 31/12/20.
//

import Foundation
import RealmSwift

struct MTRealmManager {
    static let shared = MTRealmManager()
    
    private var realm: Realm?
    
    init() {
        self.realm = try! Realm()
    }
    
    func addObject<T: Object>(_ realmObj: T)
    {
        do {
            try realm?.write() {
                realm?.add(realmObj)
            }
        }catch let error {
            print("Error writing in realm object of type \(T.self) with error: \(error)")
        }
    }
    
    func addObjects<T: Object>(_ objs: [T])
    {
        do {
            try realm?.write() {
                realm?.add(objs)
            }
        }catch let error {
            print("Error writing in realm objects of type \(T.self) with error: \(error)")
        }
    }
    
    func deleteObjs()
    {
        let realm = try! Realm()
        try! realm.write {
          realm.deleteAll()
        }
    }
}
