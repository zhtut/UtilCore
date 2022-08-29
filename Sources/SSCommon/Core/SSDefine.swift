//
//  SSDefine.swift
//  Pods
//
//  Created by shutut on 2021/8/21.
//

import Foundation

public typealias SucceedHandler = (_ succ: Bool, _ errMsg: String?) -> Void

/// 生成一个颜色，可以直接从蓝湖复制过来
/// - Parameters:
///   - r: 红
///   - g: 绿
///   - b: 蓝
///   - a: 透明度
/// - Returns: 返回生成的颜色
#if os(iOS)
import UIKit
public func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
#endif

public struct CommonError: Error, CustomStringConvertible {
    public var errMsg: String
    public init(errMsg: String) {
        self.errMsg = errMsg
    }
    public var description: String {
        return "CommonError: \(errMsg)"
    }
}

func mergeArguments(_ args: [String]) -> [String] {
    var newArgs = [String]()
    var curr = ""
    for str in args {
        if curr.count != 0 {
            if str.isIncompleted {
                curr += str
                newArgs.append(curr)
                curr = ""
            } else {
                curr += str
            }
        } else {
            if str.isIncompleted {
                curr = str
            } else {
                newArgs.append(str)
            }
        }
    }
    return newArgs
}

public extension String {
    var isIncompleted: Bool {
        if self.characterCount("\"") % 2 != 0 || self.characterCount("'") % 2 != 0 {
            return true
        }
        return false
    }
    
    func characterCount(_ char: Character) -> Int {
        var count = 0
        for c in self {
            let cStr = "\(c)"
            let charStr = "\(char)"
            if cStr == charStr {
                count += 1
            }
        }
        return count
    }
}

@discardableResult
public func runCommand(_ command: String,
                       currentDir: String? = nil,
                       args: [String] = []) async throws -> (Int32, String?) {
    let task = Process()
    let splitCommand = command.split(separator: " ")
    var arguments = splitCommand.dropFirst().map(String.init)
    let commandName = String(splitCommand.first!)
    let launchPath = "\(commandName)"
    task.executableURL = URL(fileURLWithPath: launchPath)
    print("executableURL:\(launchPath)")
    if let currentDir = currentDir {
        let currentDirURL = URL(fileURLWithPath: currentDir)
        task.currentDirectoryURL = currentDirURL
        print("currentDirectoryURL:\(currentDirURL)")
    }
    arguments = mergeArguments(arguments)
    if args.count > 0 {
        arguments += args
    }
    task.arguments = arguments
    print("arguments:\(arguments)")
    
    let pipe = Pipe()
    task.standardOutput = pipe
    task.standardError = pipe
    
    try task.run()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)
    
    print("output: \(output ?? "")")
    
    task.waitUntilExit()
    
    return (task.terminationStatus, output)
}
