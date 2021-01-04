//
//  CleanerCodeExtensions.swift
//  Plantas de Agua
//
//  Created by Alonso Fabian Orozco Perez on 26/12/20.
//

import Foundation
import AudioToolbox
import UIKit

extension UIImage {
    var squared: UIImage? {
        let originalWidth  = size.width
        let originalHeight = size.height
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        var edge: CGFloat = 0.0
        
        if (originalWidth > originalHeight) {
            // landscape
            edge = originalHeight
            x = (originalWidth - edge) / 2.0
            y = 0.0
            
        } else if (originalHeight > originalWidth) {
            // portrait
            edge = originalWidth
            x = 0.0
            y = (originalHeight - originalWidth) / 2.0
        } else {
            // square
            edge = originalWidth
        }
        
        let cropSquare = CGRect(x: x, y: y, width: edge, height: edge)
        guard let imageRef = cgImage?.cropping(to: cropSquare) else { return nil }
        
        return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
    }
    
    func resized(maxSize: CGFloat) -> UIImage? {
        let scale: CGFloat
        if size.width > size.height {
            scale = maxSize / size.width
        }
        else {
            scale = maxSize / size.height
        }
        
        let newWidth = size.width * scale
        let newHeight = size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

//TRIM String

extension String {
    
    var asDict: [String: Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
    
    var asAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
    }
    
    var asArray: [Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any]
    }
    
    var trimmed: String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var noDiacritic: String {
        self.folding(options: .diacriticInsensitive, locale: .current)
    }

    mutating func trim() {
        self = self.trimmed
    }
    
//  string to date
    func toDate(format: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        return df.date(from: self)
    }
    
    var asURL: URL? {
        URL(string: self)
    }
    
    var containsOnlyDigits: Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        return rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
    }
    
    var isAlphanumeric: Bool {
        !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isOnlyText: Bool {
        !isEmpty && range(of: "[^a-zA-Z ]", options: .regularExpression) == nil
    }
    
//    subscript (i: Int) -> Character {
//        return self[index(startIndex, offsetBy: i)]
//    }
//
//    subscript (bounds: CountableRange<Int>) -> Substring {
//        let start = index(startIndex, offsetBy: bounds.lowerBound)
//        let end = index(startIndex, offsetBy: bounds.upperBound)
//        if end < start { return "" }
//        return self[start..<end]
//    }
//
//    subscript (bounds: CountableClosedRange<Int>) -> Substring {
//        let start = index(startIndex, offsetBy: bounds.lowerBound)
//        let end = index(startIndex, offsetBy: bounds.upperBound)
//        if end < start { return "" }
//        return self[start...end]
//    }
//
//    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
//        let start = index(startIndex, offsetBy: bounds.lowerBound)
//        let end = index(endIndex, offsetBy: -1)
//        if end < start { return "" }
//        return self[start...end]
//    }
//
//    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
//        let end = index(startIndex, offsetBy: bounds.upperBound)
//        if end < startIndex { return "" }
//        return self[startIndex...end]
//    }
//
//    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
//        let end = index(startIndex, offsetBy: bounds.upperBound)
//        if end < startIndex { return "" }
//        return self[startIndex..<end]
//    }
}


//Int to double

extension Int {
    
    func toString() -> String {
        "\(self)"
    }
    
    func toDouble() -> Double {
        Double(self)
    }
    
    func centsToDollars() -> Double {
        Double(self) / 100
    }
}

extension Double {
    func toInt() -> Int {
        Int(self)
    }
    
    func toString() -> String {
        String(format: "%.02f", self)
    }
    
    func toPrice(currency: String) -> String {
        let nf = NumberFormatter()
        nf.decimalSeparator = "."
        nf.groupingSeparator = ","
        nf.groupingSize = 3
        nf.usesGroupingSeparator = true
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 0
        return currency + (nf.string(from: NSNumber(value: self)) ?? "?")
    }
}

extension Date {
    func toString(format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
}

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(1519)
    }
}

extension Bundle {
    var appVersion: String? {
        self.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    static var mainAppVersion: String? {
        Bundle.main.appVersion
    }
}
