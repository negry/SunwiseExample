//
//  MT+SotoryboardHelper.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 29/12/20.
//

import Foundation
import UIKit

enum MTStoryboard
{
    case Login
    case Dashboard
    
    var name: String {
        switch self {
    
        case .Login:
            return "Login"
        case .Dashboard:
            return "Dashboard"
        }
    }
}

struct MTSbHelper {
    
    static let shared = MTSbHelper()
    
    func initVC<T: UIViewController>(storyboard: MTStoryboard, customIdentifier: String? = nil) -> T
    {
        let storyboard = UIStoryboard(name: storyboard.name, bundle: nil)
        var identifier = ""
        if let vcIdentity = customIdentifier {
            identifier = vcIdentity
            
        }else {
            identifier = String(describing: T.self)
        }
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
