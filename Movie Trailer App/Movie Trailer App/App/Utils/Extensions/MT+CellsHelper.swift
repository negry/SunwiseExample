//
//  KOR+Tableview.swift
//  KORRecipientCardSDK
//
//  Created by Alonso Orozco  on 07/09/20.
//  Copyright © 2020 RocketKOR. All rights reserved.
//

import Foundation
import UIKit

extension UITableView
{
    func noFooterView()
    {
        self.tableFooterView = UIView()
    }
    
    func registerTableViewCell(withIdentifier identifier: String)
    {
        let cellNib = UINib(nibName: identifier, bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: identifier)
    }
    
    func activityIndicator(loadingInProgress: Bool, loadingColor: UIColor = .black) {
        let tag = 12093
        if loadingInProgress {
            let indicator = UIActivityIndicatorView()
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.tag = tag
            indicator.style = .medium
            indicator.color = loadingColor
            self.addSubview(indicator)
            self.setupIndicatorLayout(indicatorView: indicator)
            indicator.startAnimating()
            indicator.hidesWhenStopped = true
        }else {
            if let indicator = self.superview?.viewWithTag(tag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
    
    private func setupIndicatorLayout(indicatorView: UIActivityIndicatorView)
    {
        indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

extension UICollectionView
{
    func registerCell(withIdentifier identifier: String)
    {
        let cellNib = UINib(nibName: identifier, bundle: nil)
        self.register(cellNib, forCellWithReuseIdentifier: identifier)
    }
}
