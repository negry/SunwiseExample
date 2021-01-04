//
//  MT+AlertHelper.swift
//  Movie Trailer App
//
//  Created by Alonso Fabian Orozco Perez on 28/12/20.
//

import Foundation
import UIKit

class MTAlertHelper {
    
    private static let titleApp = "Movie Trailer App"
    
    class func showValidationMessageAlert(presentedView: UIViewController, message: String)
    {
        let alert = UIAlertController(title: MTAlertHelper.titleApp, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        presentedView.present(alert, animated: true, completion: nil)
    }
    
    class func showCustomMessage(currentVC: UIViewController, message: String)
    {
        let alert = UIAlertController(title: MTAlertHelper.titleApp, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(alertAction)
        currentVC.present(alert, animated: true, completion: nil)
    }
    
    class func showCustomMessageWithHandler(currentVC: UIViewController, message: String, optionalOkTextButton: String = "Ok", completionHandler: @escaping () -> Void)
    {
        let alert = UIAlertController(title: MTAlertHelper.titleApp, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: optionalOkTextButton, style: .default) { (action) in
            return completionHandler()
        }
        alert.addAction(alertAction)
        currentVC.present(alert, animated: true, completion: nil)
    }
    
//    class func showCustomMessageWithHandlerOptional(currentVC: UIViewController, message: String, completionHandler: @escaping (_ userAccept: Bool) -> Void)
//    {
//        let alert = UIAlertController(title: KORAlertHelper.titleApp, message: message, preferredStyle: .alert)
//        let takeAction = UIAlertAction(title: "", style: .default) { (action) in
//            return completionHandler(true)
//        }
//        let noAction = UIAlertAction(title: "", style: .default) { (action) in
//            return completionHandler(false)
//        }
//        alert.addAction(takeAction)
//        alert.addAction(noAction)
//        currentVC.present(alert, animated: true, completion: nil)
//    }

}

