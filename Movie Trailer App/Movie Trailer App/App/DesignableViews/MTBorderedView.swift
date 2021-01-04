

import Foundation
import UIKit

@IBDesignable
final class MTBorderedView: UIView
{
    
    @IBInspectable var allCorners: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = allCorners
        }
    }
    
    @IBInspectable var bottomRadius: CGFloat = 0 {
        didSet {
            self.clipsToBounds = true
            self.layer.cornerRadius = bottomRadius
            self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    @IBInspectable var leftBottomRadius: CGFloat = 0 {
        didSet {
            self.clipsToBounds = true
            self.layer.cornerRadius = leftBottomRadius
            self.layer.maskedCorners = [.layerMinXMaxYCorner]
        }
    }
    
    @IBInspectable var rightBottomRadius: CGFloat = 0 {
        didSet {
            self.clipsToBounds = true
            self.layer.cornerRadius = rightBottomRadius
            self.layer.maskedCorners = [.layerMaxXMaxYCorner]
        }
    }
    
    @IBInspectable var topRadius: CGFloat = 0 {
        didSet {
            self.clipsToBounds = true
            self.layer.cornerRadius = topRadius
            self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet{
            self.layer.borderColor = self.borderColor.cgColor
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

