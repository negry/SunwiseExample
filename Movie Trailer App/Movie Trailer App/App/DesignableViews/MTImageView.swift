//
//  MTImageView.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 30/12/20.
//

import Foundation
import UIKit

@IBDesignable
final class MTImageView: UIImageView
{
    
    @IBInspectable var allCorners: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = allCorners
        }
    }
    
}
