//
//  MovieTableViewCell.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 30/12/20.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var movies: [MovieRecord] = [] {
        didSet {
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        }
    }
    
    var sectionType: MoviesType?
    
    private let operations = ImageOperations()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.configView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configView()
    {
        self.movieCollectionView.delegate = self
        self.movieCollectionView.dataSource = self
        self.movieCollectionView.registerCell(withIdentifier: MovieCollectionViewCell.identifier)
    }
    
    private func startPhotoOperation(forRecord movie: MovieRecord, atIndexPath indexPath: IndexPath)
    {
        guard operations.downloadsInProgress[indexPath] == nil else {return}
        let downloader = ImageDownloader(movie: movie)
        
        downloader.completionBlock = {
            if downloader.isCancelled { return }
            DispatchQueue.main.async {
                self.operations.downloadsInProgress.removeValue(forKey: indexPath)
                self.movieCollectionView.reloadItems(at: [indexPath])
            }
        }
        
        operations.downloadOperationQueue.addOperation(downloader)
    }
    
}

extension MovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
        let currentMovie = self.movies[indexPath.row]
        cell.titleLabel.text = currentMovie.name
        cell.overviewLabel.text = currentMovie.overview
        cell.movieImageView.image = currentMovie.image
        
        switch currentMovie.state {
        case .new:
            cell.loadingIndicator.startAnimating()
            if !collectionView.isDragging && !collectionView.isDecelerating {
                startPhotoOperation(forRecord: currentMovie, atIndexPath: indexPath)
            }
        case .downloaded:
            cell.loadingIndicator.stopAnimating()
            
        case .failed:
            cell.loadingIndicator.stopAnimating()
            //validate sad path
        }
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        operations.downloadOperationQueue.isSuspended = true
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            loadImagesForOnscreenCells()
            operations.downloadOperationQueue.isSuspended = false
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenCells()
        operations.downloadOperationQueue.isSuspended = false
    }
    
    private func loadImagesForOnscreenCells() {
        
        let pathsArray = movieCollectionView.indexPathsForVisibleItems
        
        let allPendingOperations = Set(operations.downloadsInProgress.keys)
        
        var toBeCancelled = allPendingOperations
        let visiblePaths = Set(pathsArray)
        toBeCancelled.subtract(visiblePaths)
        
        var toBeStarted = visiblePaths
        toBeStarted.subtract(allPendingOperations)
        
        for indexPath in toBeCancelled {
            if let pendingDownload = operations.downloadsInProgress[indexPath] {
                pendingDownload.cancel()
            }
            
            operations.downloadsInProgress.removeValue(forKey: indexPath)
        }
        
        for indexPath in toBeStarted {
            let recordToProcess = movies[indexPath.row]
            startPhotoOperation(forRecord: recordToProcess, atIndexPath: indexPath)
        }
    }
}

extension MovieTableViewCell: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let partOfCollectionViewWidth = collectionView.frame.width / 6
        let halfOfCollectionViewWidth = collectionView.frame.width / 2
        let heightOffset: CGFloat = 10
        return CGSize(width: (halfOfCollectionViewWidth + partOfCollectionViewWidth), height: collectionView.frame.height - heightOffset)
    }
}
