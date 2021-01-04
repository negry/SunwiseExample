//
//  ImageOperations.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 29/12/20.
//

import Foundation
import UIKit

class ImageOperations
{
    lazy var downloadsInProgress: [IndexPath : Operation] = [:]
    lazy var downloadOperationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.movie.Movie-Trailer-App.downloadOperationQueue"
        return queue
    }()
}

class ImageDownloader: AsynchronousOperation
{
    var movie: MovieRecord
    
    init(movie: MovieRecord)
    {
        self.movie = movie
    }
    
    
    override func main() {
        super.main()
        
        if let movieRecordUrl = movie.backDropPathUrl {
            do {
                let imageData = try Data(contentsOf: movieRecordUrl)
                if imageData.isEmpty {
                    movie.state = .failed
                }else {
                    movie.state = .downloaded
                    movie.image = UIImage(data: imageData)
                }
            }catch let error {
                print("Error downloading image with name: \(movie.name)")
                print(error)
                movie.state = .failed
            }
        }else {
            movie.state = .failed
        }
        if movie.state == .failed {
            movie.image = #imageLiteral(resourceName: "img_placeholder")
        }
        finish()
    }
    
}
