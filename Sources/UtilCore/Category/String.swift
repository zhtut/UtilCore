//
//  String.swift
//  SSCommon
//
//  Created by zhtg on 2023/4/26.
//

import Foundation

public extension String {

    /// Create `Data` from hexadecimal string representation
    ///
    /// This creates a `Data` object from hex string. Note, if the string has any spaces or non-hex characters (e.g. starts with '<' and with a '>'), those are ignored and only hex characters are processed.
    ///
    /// - returns: Data represented by this hexadecimal string.
    var hexData: Data? {
        var data = Data(capacity: count / 2)

        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, range: NSRange(startIndex..., in: self)) { match, _, _ in
            let byteString = (self as NSString).substring(with: match!.range)
            if let num = UInt8(byteString, radix: 16) {
                data.append(num)
            }
        }

        guard data.count > 0 else { return nil }

        return data
    }
    
    func split(_ separator: Character) -> [String] {
        split(separator: separator)
            .map({ "\($0)" })
    }
}
