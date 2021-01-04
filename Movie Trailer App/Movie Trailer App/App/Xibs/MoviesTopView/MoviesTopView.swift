//
//  MoviesFooterView.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 29/12/20.
// 
//

import UIKit

class MoviesTopView: UIView {
    
    @IBOutlet weak var upcommingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionActivityIndicatorView: UIActivityIndicatorView!
    
    private var presenter: MoviesFooterPresenterProtocol?
    
    private var movieRecords: [MovieRecord] = []
    private let operations = ImageOperations()
    
    // MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    private func configView() {
        self.xibSetup()
        self.collectionActivityIndicatorView.startAnimating()
        self.upcommingCollectionView.isPagingEnabled = true
        self.upcommingCollectionView.delegate = self
        self.upcommingCollectionView.dataSource = self
        self.upcommingCollectionView.registerCell(withIdentifier: MovieTopViewCollectionViewCell.identifier)
        self.setupPresenter()
        self.pageControl.hidesForSinglePage = true
        self.pageControl.numberOfPages = 5
        self.pageControl.currentPage = 0
        self.presenter?.loadMoviesData()
    }
    
    private func setupPresenter()
    {
        self.presenter = MoviesFooterPresenter()
        presenter?.view = self
        presenter?.viewDidLoad()
    }
    
    private func startPhotoOperation(forRecord movie: MovieRecord, atIndexPath indexPath: IndexPath)
    {
        guard operations.downloadsInProgress[indexPath] == nil else {return}
        let downloader = ImageDownloader(movie: movie)
        
        downloader.completionBlock = {
            if downloader.isCancelled { return }
            DispatchQueue.main.async {
                self.operations.downloadsInProgress.removeValue(forKey: indexPath)
                self.upcommingCollectionView.reloadItems(at: [indexPath])
            }
        }
        
        operations.downloadOperationQueue.addOperation(downloader)
    }
}

extension MoviesTopView: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieTopViewCollectionViewCell.identifier, for: indexPath) as! MovieTopViewCollectionViewCell
        let currentMovieRecord = self.movieRecords[indexPath.row]
        cell.movieName.text = currentMovieRecord.name
        cell.backdropImage.image = currentMovieRecord.image
        
        switch currentMovieRecord.state {
        case .new:
            cell.loadingIndicator.startAnimating()
            if !collectionView.isDragging && !collectionView.isDecelerating {
                startPhotoOperation(forRecord: currentMovieRecord, atIndexPath: indexPath)
            }
        case .downloaded:
            cell.loadingIndicator.stopAnimating()
        case .failed:
            cell.loadingIndicator.stopAnimating()
            //validate sad path
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieRecords.count
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
        let count = scrollView.contentOffset.x / scrollView.frame.size.width
        self.pageControl.currentPage = Int(count)
        loadImagesForOnscreenCells()
        operations.downloadOperationQueue.isSuspended = false
    }
    
    private func loadImagesForOnscreenCells() {
        
        let pathsArray = upcommingCollectionView.indexPathsForVisibleItems
        
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
            let recordToProcess = movieRecords[indexPath.row]
            startPhotoOperation(forRecord: recordToProcess, atIndexPath: indexPath)
        }
    }
    
}

extension MoviesTopView: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension MoviesTopView: MoviesTopViewProtocol
{
    func onMoviesLoaded(movies: [MovieListResultObject]) {
        for movie in movies {
            let movie = MovieRecord(name: movie.originalTitle, backDropPath: movie.backdropPath, overview: movie.overview)
            self.movieRecords.append(movie)
        }
        DispatchQueue.main.async {
            self.upcommingCollectionView.reloadData()
        }
    }
    
    func onRequestFailed(error: String) {
        print(error)
    }
    
    func showProgress() {
        DispatchQueue.main.async {
            self.collectionActivityIndicatorView.isHidden = false
            self.collectionActivityIndicatorView.startAnimating()
        }
    }
    
    func hideProgress() {
        DispatchQueue.main.async {
            self.collectionActivityIndicatorView.isHidden = true
        }
    }
    
    
}
