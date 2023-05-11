//
//  Error.swift
//  GoodMood
//
//  Created by zhtg on 2023/4/14.
//  Copyright © 2023 Buildyou Tech. All rights reserved.
//

import Foundation

public struct MsgErr: Error, CustomStringConvertible {

    public var msg: String

    public init(msg: String) {
        self.msg = msg
    }

    public var description: String {
        return msg
    }
}
