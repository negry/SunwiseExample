//
//  MovieTableViewHeader.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 30/12/20.
// 
//

import UIKit

//Uncomment for Designable Class
//@IBDesignable
class MovieTableViewHeader: UIView {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
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
    }
}
