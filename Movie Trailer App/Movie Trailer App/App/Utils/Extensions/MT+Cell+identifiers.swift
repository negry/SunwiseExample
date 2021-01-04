//
//  RB+UITableViewCell+identifiers.swift
//
//  Created by Alonso Orozco  on 17/12/20.
//  Copyright © 2020 RocketKOR. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell
{
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
