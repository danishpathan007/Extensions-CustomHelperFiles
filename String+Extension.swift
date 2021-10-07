
import Foundation
import UIKit

extension String {
    
    func attributedStringWithColor(_ strings: [String], color: UIColor,font:UIFont,characterSpacing: UInt? = nil) -> NSAttributedString {
           let attributedString = NSMutableAttributedString(string: self)
           for string in strings {
               let range = (self as NSString).range(of: string)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: color,NSAttributedString.Key.font: font], range: range)
           }

           guard let characterSpacing = characterSpacing else {return attributedString}

           attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

           return attributedString
       }
    
    
    func trimSpace() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var length:Int{
        return self.count
    }
    
    var localized:String {
        return NSLocalizedString(self, comment: self)
    }
    var simplePhoneNumber:String {
        var string = self.replacingOccurrences(of: "-", with: "")
        string = string.replacingOccurrences(of: "(", with: "")
        string = string.replacingOccurrences(of: ")", with: "")
        string = string.replacingOccurrences(of: " ", with: "")
        return string
    }
    
    var toInt:Int? {
        return Int.init(self)
    }
    
    var toFloat:Float? {
        return Float.init(self)
    }
    
    var toDouble:Double? {
        return Double.init(self)
    }
    var html2AttributedString : NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func size(OfFont font: UIFont) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedString.Key.font: font])
    }
   
    func ltrim(_ str: String, _ chars: Set<Character>) -> String {
        if let index = str.firstIndex(where: {!chars.contains($0)}) {
            return String(str[index..<str.endIndex])
        } else {
            return ""
        }
    }
    
    var validURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }


}


extension Int {
    
    var toString:String{
        return String.init(describing: self)
    }
}


extension Double {
    
    var toString:String{
        return String.init(describing: self)
    }
}


extension Float{
    
    var toString:String{
        return String.init(describing: self)
    }
}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

protocol DataModel{}
extension String:DataModel {}
extension Int:DataModel {}
extension Array:DataModel{}
extension Dictionary:DataModel{}

extension DataModel
{
    var toString:String?{
        return self as? String
    }
    var toArray:Array<Any>?{
        return self as? Array
    }
    
    var toDictionary:Dictionary<String, Any>?{
        return self as? Dictionary<String, Any>
    }
}

//MARK:- UITapGesture Label Extension
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
        
    }
    
}
