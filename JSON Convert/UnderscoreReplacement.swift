//
//  UnderscoreReplacement.swift
//  JSON Convert
//
//  Created by Frank Michael on 8/23/14.
//  Copyright (c) 2014 Frank Michael Sanchez. All rights reserved.
//

import Foundation

extension String {
    func underscoreReplacement() -> String {
        let stringAsNSString: NSString = self
        if let range = self.rangeOfString("_", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil) {
            println(range)
            let underScoreRange = range.startIndex
            let beforeUnder = self.substringToIndex(underScoreRange)
            let afterUnder = self.substringFromIndex(underScoreRange.successor()).capitalizedString
            var cleaned = "\(beforeUnder)\(afterUnder)"
            if let range = cleaned.rangeOfString("_", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil) {
                cleaned = cleaned.underscoreReplacement()
                return cleaned
            }
            return cleaned;
        }
        return self;
    }
}