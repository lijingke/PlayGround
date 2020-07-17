//
//  String+Extension.swift
//  PlayGround
//
//  Created by 李京珂 on 2020/6/9.
//  Copyright © 2020 李京珂. All rights reserved.
//

import UIKit

extension String {
    public func getTextSize(size: CGSize, attributesDict:[NSAttributedString.Key : Any]) -> CGSize {
        let str = self as NSString;
        return str.boundingRect(with: size, options: [.usesLineFragmentOrigin], attributes: attributesDict, context: nil).size;
    }
}

extension String {
    func toNSRange(_ range: Range<String.Index>) -> NSRange {
        guard let from = range.lowerBound.samePosition(in: utf16), let to = range.upperBound.samePosition(in: utf16) else {
            return NSMakeRange(0, 0)
        }
        return NSMakeRange(utf16.distance(from: utf16.startIndex, to: from), utf16.distance(from: from, to: to))
    }
    
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
        guard let from = String.Index(from16, within: self) else { return nil }
        guard let to = String.Index(to16, within: self) else { return nil }
        return from ..< to
    }
}

extension String {
  
  /// 字符串的匹配范围 方法一
  ///
  /// - Parameters:
  ///     - matchStr: 要匹配的字符串
  /// - Returns: 返回所有字符串范围
  public func exMatchStrRange(matchStr: String) -> [NSRange] {
    var allLocation = [Int]() //所有起点
    let matchStrLength = (matchStr as NSString).length  //currStr.characters.count 不能正确统计表情
    let arrayStr = self.components(separatedBy: matchStr)
    var currLoc = 0
    arrayStr.forEach { currStr in
      currLoc += (currStr as NSString).length
      allLocation.append(currLoc)
      currLoc += matchStrLength
    }
    allLocation.removeLast()
    return allLocation.map { NSRange(location: $0, length: matchStrLength) } //可把这段放在循环体里面，同步处理，减少再次遍历的耗时
  }
  
  /// 字符串的匹配范围 方法二(推荐)
  ///
  /// - Parameters:
  ///     - matchStr: 要匹配的字符串
  /// - Returns: 返回所有字符串范围
  public func exMatchStrNSRange(matchStr: String) -> [NSRange] {
    var selfStr = self as NSString
    var withStr = Array(repeating: "X", count: matchStr.count).joined(separator: "")
    if matchStr == withStr { withStr = withStr.lowercased() } //临时处理辅助字符串差错
    var allRange = [NSRange]()
    while selfStr.range(of: matchStr).location != NSNotFound {
      let range = selfStr.range(of: matchStr)
      allRange.append(NSRange(location: range.location,length: range.length))
      selfStr = selfStr.replacingCharacters(in: NSMakeRange(range.location, range.length), with: withStr) as NSString
    }
    return allRange
  }
  
  public func rangeOf(string: String) -> NSRange {
    let selfStr = self as NSString;
    return selfStr.range(of: string);
  }
}

extension String {
  
  public func removeCharsFromEnd(count_:Int) -> String {
    let stringLength = self.count
    let substringIndex = (stringLength < count_) ? 0 : stringLength - count_
    let index = self.index(self.startIndex, offsetBy: substringIndex)
    return String(self[...index])
  }
  
}

extension String {
  public func heightForView(font:UIFont, width:CGFloat) -> CGFloat{
         let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
         label.numberOfLines = 0
         label.lineBreakMode = NSLineBreakMode.byWordWrapping
         label.font = font
         label.text = self
         label.sizeToFit()
         return label.frame.height
     }
}
