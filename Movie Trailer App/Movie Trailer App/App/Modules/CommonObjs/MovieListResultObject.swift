//
//  MovieListResultObject.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 29/12/20.
//

import Foundation
import UIKit
import RealmSwift

@objcMembers class MovieListResultObject: Object, Codable {
    
    @objc dynamic var adult : Bool
    @objc dynamic var backdropPath : String?
    @objc dynamic var posterPath : String?
    dynamic var genreIds = List<Int>()
    @objc dynamic var id : Int
    @objc dynamic var originalLanguage : String
    @objc dynamic var originalTitle : String
    @objc dynamic var overview : String
    @objc dynamic var popularity : Float
    @objc dynamic var releaseDate : String
    @objc dynamic var title : String
    @objc dynamic var video : Bool
    @objc dynamic var voteAverage : Float
    @objc dynamic var voteCount : Int
    
    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    override static func indexedProperties() -> [String] {
        return ["title"]
    }
    
    override static func ignoredProperties() -> [String] {
        return ["genreIds"]
    }
    
}
