//
//  MovieFooterCollectionViewCell.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 29/12/20.
//

import UIKit

class MovieTopViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        loadingIndicator.hidesWhenStopped = true
        DispatchQueue.main.async {
            self.backdropImage.setGradientBackground(colorTop: .clear, colorBottom: UIColor.black.withAlphaComponent(0.5))
        }
    }
    
}

extension UIImageView
{
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "gradient"
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
