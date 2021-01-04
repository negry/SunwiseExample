//
//  Show+Hide+Buttons.swift
//  Plantas de Agua
//
//  Created by Alonso Fabian Orozco Perez on 25/12/20.
//

import Foundation
import UIKit

extension UIButton
{
    func enableButtonAnimated(animated: Bool = true)
    {
        if self.alpha != 1 && self.isEnabled == false {
            DispatchQueue.main.async {
                if animated {
                    UIView.animate(withDuration: 0.3) {
                        self.alpha = 1
                        self.isEnabled = true
                    }
                }else {
                    self.alpha = 1
                    self.isEnabled = true
                }
                
            }
        }
    }
    
    func disableButtonAnimated(alpha: CGFloat = 0, animated: Bool = true)
    {
        if self.isEnabled {
            DispatchQueue.main.async {
                if animated {
                    UIView.animate(withDuration: 0.3) {
                        self.alpha = alpha
                        self.isEnabled = false
                    }
                }else {
                    self.alpha = alpha
                    self.isEnabled = false
                }
            }
        }
    }
    
    func disableButton(alpha: CGFloat = 0)
    {
        if self.isEnabled {
            self.alpha = alpha
            self.isEnabled = false
        }
    }
}

