//
//  Data.swift
//  SSCommon
//
//  Created by zhtg on 2023/4/26.
//

import Foundation

public extension Sequence where Element == UInt8 {
    public var hex: String {
        return reduce("") {$0 + String(format: "%02x", $1)}
    }
}
