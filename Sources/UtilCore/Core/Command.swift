//
//  File.swift
//  
//
//  Created by zhtg on 2022/9/24.
//

import Foundation

#if os(MacOS) || os(Linux)
public struct CommandError: Error, CustomStringConvertible {
    public var errMsg: String
    public var description: String {
        return "CommandError: \(errMsg)"
    }
}

extension ArraySlice where Element == String {
    func mergeArguments() -> [String] {
        var newArgs = [String]()
        var curr = ""
        for str in self {
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
}

extension String {
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

func findCommandPath(_ command: String) throws -> String {
    let fm = FileManager.default
    if fm.fileExists(atPath: command) {
        return command
    }
    let paths = [
        "/Library/Frameworks/Python.framework/Versions/3.10/bin",
        "/usr/local/bin",
        "/usr/bin",
        "/bin",
        "/usr/sbin",
        "/sbin",
        "/Library/Apple/usr/bin",
        "/usr/local/sbin",
        "/usr/games",
        "/usr/local/games",
        "/snap/bin",
    ]
    for pa in paths {
        let full = pa + "/\(command)"
        if fm.fileExists(atPath: full) {
            return full
        }
    }
    throw CommandError(errMsg: "command not found: \(command)")
}

@discardableResult
public func runCommand(_ command: String,
                       currentDir: String? = nil,
                       args: [String] = []) async throws -> (Int32, String) {
    let task = Process()
    let array = command.components(separatedBy: " ")
    
    // command
    guard let commandName = array.first else {
        throw CommandError(errMsg: "command not found:\(command)")
    }
    let commandPath = try findCommandPath(commandName)
    let url = URL(fileURLWithPath: commandPath)
    task.executableURL = url
    
    // currentDir
    if let currentDir = currentDir {
        let currentDirURL = URL(fileURLWithPath: currentDir)
        task.currentDirectoryURL = currentDirURL
    }
    
    // arguments
    let other = array.dropFirst()
    var arguments = other.mergeArguments()
    if args.count > 0 {
        arguments += args
    }
    task.arguments = arguments
    
    // pipe
    let pipe = Pipe()
    task.standardOutput = pipe
    task.standardError = pipe
    
    // run
    try task.run()
    
    // result
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8) ?? ""
    
    let argumentStr = arguments.joined(separator: " ")
    let commandStr = commandName + " " + argumentStr
    print("command:\(commandStr)\noutput:\(output)")
    
    task.waitUntilExit()
    
    return (task.terminationStatus, output)
}

#endif
