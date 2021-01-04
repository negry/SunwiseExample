//
//  MoviesOperations.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 30/12/20.
//

import Foundation

class MovieDataDownloader: AsynchronousOperation
{
    var movies: [MovieRecord]
    var error: MTServiceError?
    
    private let movieDataType: MoviesType
    
    init(movieRecords: [MovieRecord] = [], forMovieType type: MoviesType)
    {
        self.movies = movieRecords
        self.movieDataType = type
    }
    
    override func main() {
        super.main()
        let router: MTRouter = (movieDataType == .popular) ? .popularMovies : .topRatedMovies
        MTService.genericRequest(router: router) { [weak self] (result: MTServiceResult<MoviesResponse>) in
            
            if let strongSelf = self {
                switch result {
                case .success(let response):
                    for movieObj in response.results {
                        strongSelf.movies.append(MovieRecord(name: movieObj.originalTitle, backDropPath: movieObj.backdropPath, overview: movieObj.overview))
                    }

                case .failure(let error):
                    strongSelf.error = error
                }
                
                strongSelf.finish()
                
            }else {
                self?.finish()
            }
            
        }
    }
}
