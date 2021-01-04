//
//  MovieRecord.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 29/12/20.
//

import Foundation
import UIKit
import RealmSwift

enum MovieRecordState {
    case new, downloaded, failed
}

class MovieRecord {
    let name: String
    var backDropPathUrl: URL? = nil
    var state: MovieRecordState = .new
    var image: UIImage?
    var overview: String
    
    init(name: String, backDropPath: String?, overview: String){
        self.name = name
        if let backImagePath = backDropPath {
            self.backDropPathUrl = URL(string: "https://image.tmdb.org/t/p/w500\(backImagePath)")
        }
        self.overview = overview
    }
}
