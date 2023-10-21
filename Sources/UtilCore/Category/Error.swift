//
//  Error.swift
//  GoodMood
//
//  Created by zhtg on 2023/4/14.
//  Copyright © 2023 Buildyou Tech. All rights reserved.
//

import Foundation

/// 通用错误
public struct MessageError: Error, CustomStringConvertible, LocalizedError {

    public var message: String
    
    public init(message: String) {
        self.message = message
    }

    public var description: String {
        return message
    }

    public var errorDescription: String {
        return message
    }
}
