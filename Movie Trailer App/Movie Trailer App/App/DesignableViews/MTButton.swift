//
//  MTButton.swift
//
//  Created by Alonso Fabian Orozco Perez on 28/12/20.
//

import Foundation
import UIKit

@IBDesignable
final class MTButton: UIButton
{
    @IBInspectable var isCircular: Bool = false {
        didSet{
            self.layer.cornerRadius = (isCircular) ? self.frame.height / 2 : 0
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var leftCornerRadius: CGFloat = 0
    
    @IBInspectable var rightCornerRadius: CGFloat = 0
    
    @IBInspectable var onlyLeftCornerRadius: Bool = false {
        didSet{
            if onlyLeftCornerRadius {
                self.clipsToBounds = true
                self.layer.cornerRadius = leftCornerRadius
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            }else {
                self.layer.cornerRadius = self.cornerRadius
            }
        }
    }
    
    @IBInspectable var onlyRightCornerRadius: Bool = false {
        didSet{
            if onlyRightCornerRadius {
                self.clipsToBounds = true
                self.layer.cornerRadius = rightCornerRadius
                self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            }else {
                self.layer.cornerRadius = self.cornerRadius
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
