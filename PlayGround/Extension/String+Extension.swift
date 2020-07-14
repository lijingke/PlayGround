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
