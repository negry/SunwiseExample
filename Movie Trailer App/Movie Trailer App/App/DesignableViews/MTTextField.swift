//
//
//  Created by Alonso Fabian Orozco Perez on 28/12/20.
//

import Foundation
import UIKit

@IBDesignable
final class MTTextField: UITextField
{
    static let BOTTOM_BORDER_NAME = "BottomBorderTxT"
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet{
            updateTextView()
        }
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet{
            updateTextView()
        }
    }
    
    @IBInspectable var bottomBorderColor: UIColor = UIColor.black {
        didSet {
            updateBottomLayer()
        }
    }
    
    @IBInspectable var bottomBorderWidth: CGFloat = 0 {
        didSet{
            updateBottomLayer()
        }
    }
    
    func updateBottomLayer()
    {
        for layer in self.layer.sublayers! {
            if layer.name == MTTextField.BOTTOM_BORDER_NAME {
                layer.removeFromSuperlayer()
            }
        }
        let border = CALayer()
        border.name = MTTextField.BOTTOM_BORDER_NAME
        let width = bottomBorderWidth
        border.borderColor = self.bottomBorderColor.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    private func updateTextView()
    {
        if let userImage = leftImage {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 5 + leftPadding, height: self.frame.height))
            imageView.image = userImage
            imageView.contentMode = .left
            self.leftView = imageView
            self.leftViewMode = .always
        }else {
            self.leftViewMode = .never
            self.leftView = nil
        }
    }
}
