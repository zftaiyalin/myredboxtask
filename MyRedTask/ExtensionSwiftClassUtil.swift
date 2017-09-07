//
//  ExtensionSwiftClass.swift
//  ZXReader
//
//  Created by 中新金桥 on 16/7/19.
//  Copyright © 2016年 刘成军. All rights reserved.
//

import UIKit
import Foundation


extension NSString {
    func rangesOfSpecial(_ regular: String) -> Array<NSRange>? {
        return (self as String).rangesOfSpecial(regular)
    }
    
    func trim() -> NSString {
        return (self as String).trim()
    }
    
    subscript(start: Int) -> String {
        return (self as String)[start]
    }
    
    subscript(r: Range<Int>) -> String {
        return (self as String)[r]
    }
}

extension String {
    func toInt() -> Int {
       return (self as NSString).integerValue
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func trimHtmlSpace() -> String {
        return self.components(separatedBy: "<br>").joined(separator: "").trim()
    }
    
    func trimHtmlFirstBr() -> String {
        return self.replacingOccurrences(of: "<br>", with: "", options: NSString.CompareOptions.caseInsensitive, range: self.range(of: "<br>"))
    }
    
    var length: Int {
        return (self as NSString).length
    }
    
    func rangesOfSpecial(_ regular: String) -> Array<NSRange>? {
        var array = [NSRange]()
         let range = NSMakeRange(0, self.length)
        let reg = try?NSRegularExpression(pattern: regular, options: NSRegularExpression.Options.caseInsensitive)
        reg?.enumerateMatches(in: self as String, options: NSRegularExpression.MatchingOptions.reportCompletion, range: range, using: { (result, flags, objc) in
            if flags != NSRegularExpression.MatchingFlags.internalError {
                if let item = result?.rangeAt(0) {
                    array.append(item)
                }
            }
        })
        
        return array.isEmpty ? nil : array
    }
    
    
    static func textHeightFromString(_ text: String,textWidth:CGFloat,fontSize:CGFloat) -> CGFloat {
        
        let dict = [NSFontAttributeName:UIFont.systemFont(ofSize: fontSize)]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = (text as NSString).boundingRect(with: CGSize(width: textWidth-20, height: CGFloat(MAXFLOAT)), options: option, attributes: dict, context: nil)
        return rect.size.height
    }
    
    func stringWidthWithFixHeight(_ textHeight: CGFloat, fontSize: CGFloat) -> CGFloat {
        let dict = [NSFontAttributeName:UIFont.systemFont(ofSize: fontSize)]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = (self as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: textHeight), options: option, attributes: dict, context: nil)
        return rect.size.width
    }
    
    
    /// Truncates the string to length number of characters and
    /// appends optional trailing string if longer
    func truncate(_ length: Int, trailing: String? = nil) -> String {
        if self.characters.count > length {
            return self.substring(to: self.characters.index(self.startIndex, offsetBy: length)) + (trailing ?? "")
        } else {
            return self
        }
    }
    
    func stripHtml() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
    
    func stripLineBreaks() -> String {
        return self.replacingOccurrences(of: "\n", with: "", options: .regularExpression)
    }
    
    subscript(start: Int) -> String {
        return self[start..<start+1]
    }
    subscript(r: Range<Int>) -> String {
        let startIndex = self.characters.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.characters.index(self.startIndex, offsetBy: r.upperBound > self.characters.count ? self.characters.count : r.upperBound)
        return self[Range(startIndex..<endIndex)]
    }
    func wordAttributedStringFromString(_ fontSize:CGFloat, color:String) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        let attrStr = try! NSMutableAttributedString.init(data: (self.data(using: String.Encoding.unicode))!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        attrStr.addAttribute(NSForegroundColorAttributeName, value: UIColor(rgba:color), range: NSMakeRange(0, attrStr.length))
        attrStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: fontSize), range: NSMakeRange(0, attrStr.length))
        attrStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attrStr.length))
        return attrStr
    }
    func setAttriStr(_ font:UIFont, color:UIColor? ,para:NSMutableParagraphStyle?, isAddParagraph:Bool)->NSMutableAttributedString{
        let attrStr = try! NSMutableAttributedString.init(data: (self.data(using: String.Encoding.unicode))!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        
        
        attrStr.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, attrStr.length))
        if color != nil{
            attrStr.addAttribute(NSForegroundColorAttributeName, value: color!, range: NSMakeRange(0, attrStr.length))
        }
        if para != nil{
            attrStr.addAttribute(NSParagraphStyleAttributeName, value: para!, range: NSMakeRange(0, attrStr.length))
        }else{
            if isAddParagraph{
                let paragraph = NSMutableParagraphStyle()
                paragraph.alignment = NSTextAlignment.center
                attrStr.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: NSMakeRange(0, attrStr.length))
            }
        }
        
        return attrStr
    }
}
//extension NSAttributedString{
//    func attributedStringWidth() -> CGFloat {
//        let option = NSStringDrawingOptions.usesLineFragmentOrigin
//        let rect:CGRect = self.boundingRectWithSize(CGSizeMake(CGFloat(MAXFLOAT), self.a), options: option, attributes: self, context: nil)
//        return rect.size.width
//    }
//}
extension NSObject {
    class func fromClassName(_ className : String) -> NSObject {
        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + className
        let aClass = NSClassFromString(className) as! UIViewController.Type
        return aClass.init()
    }
    
}

extension Int {
    func toString() -> String {
        return "\(self)"
    }
}

extension Float {
    func toString() -> String {
        return "\(self)"
    }
}

extension Double {
    func toString() -> String {
        return "\(self)"
    }
}

extension Int64 {
    func toString() -> String {
        return "\(self)"
    }
}

extension CGFloat {
    func toString() -> String {
        return "\(self)"
    }
}


extension UICollectionView {
    func showNoDataString() {
        
        removeNoData()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wu-content")
        imageView.tag = 2312
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(-30)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width: 132, height: 80))
        }
        
        
        
        let label = UILabel()
        label.textColor = UIColor(rgba: "#485b7e")
        label.text = "没有相关数据"
        label.tag = 2132
        label.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.height.equalTo(25)
        }
    }
    
    func showNoQuestionDataString() {
        
        removeNoData()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wu-content")
        imageView.tag = 2312
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self).offset(-30)
            make.centerX.equalTo(self)
            make.size.equalTo(CGSize(width: 132, height: 80))
        }
        
        let label = UILabel()
        label.textColor = UIColor(rgba: "#485b7e")
        label.text = "暂无相关问答"
        label.tag = 2132
        label.font = UIFont.systemFont(ofSize: 20)
        self.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.height.equalTo(25)
        }
    }
    
    func removeNoData() {
        let im = self.viewWithTag(2312)
        if im != nil {
            im?.removeFromSuperview()
        }
        
        let iml = self.viewWithTag(2132)
        if iml != nil {
            iml?.removeFromSuperview()
        }
    }
}

extension UIColor {
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = rgba.characters.index(rgba.startIndex, offsetBy: 1)
            let hex     = rgba.substring(from: index)
            let scanner = Scanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.characters.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                    break
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                    break
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                    break
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                    break
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                    break
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix", terminator: "")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    /**
     Hex string of a UIColor instance.
     
     - parameter rgba: Whether the alpha should be included.
     */
    // from: https://github.com/yeahdongcn/UIColor-Hex-Swift
    func hexString(_ includeAlpha: Bool) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        if (includeAlpha) {
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a * 255))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
    
    // MARK: - color shades
    // https://gist.github.com/mbigatti/c6be210a6bbc0ff25972
    
    func highlightColor() -> UIColor {
        
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: 0.30, brightness: 1, alpha: alpha)
        } else {
            return self;
        }
        
    }
    
    /**
     Returns a lighter color by the provided percentage
     
     :param: lighting percent percentage
     :returns: lighter UIColor
     */
    func lighterColor(_ percent : Double) -> UIColor {
        return colorWithBrightnessFactor(CGFloat(1 + percent));
    }
    
    /**
     Returns a darker color by the provided percentage
     
     :param: darking percent percentage
     :returns: darker UIColor
     */
    func darkerColor(_ percent : Double) -> UIColor {
        return colorWithBrightnessFactor(CGFloat(1 - percent));
    }
    
    /**
     Return a modified color using the brightness factor provided
     
     :param: factor brightness factor
     :returns: modified color
     */
    func colorWithBrightnessFactor(_ factor: CGFloat) -> UIColor {
        var hue : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha : CGFloat = 0
        
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: hue, saturation: saturation, brightness: brightness * factor, alpha: alpha)
        } else {
            return self;
        }
    }
}





