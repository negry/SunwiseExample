//
//  MTHttpRouter.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 29/12/20.
//

import Foundation
enum MTRouter
{
    case upcomingMovies
    case topRatedMovies
    case popularMovies
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        switch self {
        default:
            return "api.themoviedb.org"
        }
    }
    
    var port: Int? {
        switch self {
        default:
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .upcomingMovies:
            return "/3/movie/upcoming"
        case .topRatedMovies:
            return "/3/movie/top_rated"
        case .popularMovies:
            return "/3/movie/popular"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        default:
            return [
                URLQueryItem(name: "page", value: 1.description)
            ]
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    var headers: [String : String] {
        switch self {
        
        default:
            return [
                "Authorization": "Bearer \(MTDefaultsHelper.shared.getString(key: .BEARER_TOKEN) ?? "")",
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
        }
    }
}
