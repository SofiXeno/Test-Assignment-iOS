//
//  String + asterisk masked.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import Foundation

extension String {

    func masked(matching regexPattern: String, with template: String = "*") throws -> String {
        let regex = try NSRegularExpression(pattern: regexPattern, options: NSRegularExpression.Options.caseInsensitive)
        let range = NSMakeRange(0, count)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: template)
    }
}
