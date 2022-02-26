//
//  File.swift
//  
//
//  Created by tuguang zhou on 2022/2/19.
//

import XCTest

@testable import SSCommon

final class SSCommonTests: XCTestCase {
    
    func testNumber() {
        let str = "0.3351"
        let number = str.doubleValue
        if number == 0.3351 {
            print("yes")
        } else {
            print("no")
        }
    }
    
    func testTimestamp() {
        let str = String.timestamp
        print(str)
        
    }
}
