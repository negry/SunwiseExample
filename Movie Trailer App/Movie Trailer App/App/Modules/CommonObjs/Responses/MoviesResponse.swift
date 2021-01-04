//
//  MoviesResponse.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 29/12/20.
//

import Foundation

struct MoviesResponse: Codable {
    let dates: ReleaseDates?
    let page: Int
    let results: [MovieListResultObject]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey
    {
        case dates = "dates"
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
