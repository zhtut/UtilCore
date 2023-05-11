//
//  SSCommon.swift
//  Pods
//
//  Created by shutut on 2021/7/28.
//

import Foundation

public func max<T: Comparable>(_ a: T, _ b: T) -> T {
    return a > b ? a : b
}

public func min<T: Comparable>(_ a: T, _ b: T) -> T {
    return a < b ? a : b
}

public func dabs(_ a: Decimal) -> Decimal {
    return a < 0 ? -a : a
}

public extension Array {
    var jsonStr: String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            let str = String(data: data, encoding: .utf8)
            return str
        }
        return nil
    }
}

public extension Decimal {
    var doubleValue: Double? {
        return Double(exactly: self as NSNumber)
    }
    var stringValue: String {
        return "\(self)"
    }
    /// 取精度
    /// - Parameter count: 小数点后几位
    /// - Returns: 获取精度后的数据
    func precisionStringWith(count: Int) -> String {
        let format = NumberFormatter()
        format.minimumFractionDigits = 0
        format.maximumFractionDigits = count
        format.roundingMode = .halfUp
        let str = format.string(for: self)
        return str ?? ""
    }
    
    /// 取精度
    /// - Parameter precision: 精度字符串，如0.000001
    /// - Returns: 获取精度后的数据
    func precisionStringWith(precision: String) -> String {
        let count = precision.precision
        return precisionStringWith(count: count)
    }
}

public extension Dictionary {

    var jsonStr: String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            let str = String(data: data, encoding: .utf8)
            return str
        }
        return nil
    }
    
    func stringFor(_ key: String) -> String? {
        guard let dic = self as? [String: Any] else {
            return nil
        }
        if let value = dic[key] as? String {
            return value
        } else if let value = dic[key] {
            return "\(value)"
        }
        return nil
    }
    
    func boolFor(_ key: String) -> Bool? {
        guard let dic = self as? [String: Any] else {
            return nil
        }
        if let value = dic[key] as? Bool {
            return value
        } else if let value = dic.intFor(key) {
            return value != 0
        } else if let value = dic.stringFor(key) {
            return !value.isEmpty
        } else if let value = dic.doubleFor(key) {
            return value != 0
        }
        return false
    }
    
    func intFor(_ key: String) -> Int? {
        guard let dic = self as? [String: Any] else {
            return nil
        }
        if let value = dic[key] as? Int {
            return value
        } else if let value = dic[key] as? Double {
            return Int(value)
        } else if let value = dic[key] as? String {
            return Int(value)
        }
        return nil
    }
    
    func doubleFor(_ key: String) -> Double? {
        guard let dic = self as? [String: Any] else {
            return nil
        }
        if let value = dic[key] as? Double {
            return value
        } else if let value = dic[key] as? Int {
            return Double(value)
        } else if let value = dic[key] as? String {
            return Double(value)
        }
        return nil
    }
    
    func arrayFor(_ key: String) -> [Any]? {
        guard let dic = self as? [String: Any] else {
            return nil
        }
        if let value = dic[key] as? [Any] {
            return value
        }
        return nil
    }

    func dictionaryFor(_ key: String) -> [String: Any]? {
        guard let dic = self as? [String: Any] else {
            return nil
        }
        if let value = dic[key] as? [String: Any] {
            return value
        }
        return nil
    }
}

public extension Array where Element: Equatable {
    mutating func remove(_ element: Element) {
        if let index = firstIndex(of: element) {
           remove(at: index)
        }
    }
}

public extension String {
  
    func suffix(fromString: String) -> String {
        if let startRange = range(of: fromString) {
            let str = suffix(from: startRange.upperBound)
            return "\(str)"
        }
        return self
    }
    
    func prefix(toString: String) -> String {
        if let endRange = self.range(of: toString) {
            let str = prefix(upTo: endRange.lowerBound)
            return "\(str)"
        }
        return self
    }
    
    var double: Double? {
        return Double(self)
    }

    func defaultDouble(_ `default`: Double = 0.0) -> Double {
        return double ?? `default`
    }
    
    var int: Int? {
        return Int(self)
    }

    func defaultInt(_ `default`: Int = 0) -> Int {
        return int ?? `default`
    }
    
    var decimal: Decimal? {
        return Decimal(string: self)
    }

    func defaultDecimal(_ `default`: Decimal = 0.0) -> Decimal {
        return decimal ?? `default`
    }
    
    var precision: Int {
        var newPre = self
        while newPre.hasSuffix("0") {
            newPre = "\(newPre.prefix(newPre.count - 2))"
        }
        let arr = newPre.components(separatedBy: ".")
        if arr.count == 1 {
            return 0
        }
        if let str = arr.last {
            return str.count
        }
        return 0
    }
    
    func urlEncodeString() -> String? {
        let characters = "!*'();:@&=+$,/?%#[]"
        let set = CharacterSet(charactersIn: characters).inverted
        let str = self.addingPercentEncoding(withAllowedCharacters: set)
        return str
    }
}

public extension Double {
    var string: String {
        return "\(self)"
    }
    
    var decimal: Decimal {
        return Decimal(self)
    }
}

public extension Int {
    var string: String {
        return "\(self)"
    }
    var double: Double {
        return Double(self)
    }
    var decimal: Decimal {
        return Decimal(self)
    }
}

public extension Double {
    /// 取精度
    /// - Parameter count: 小数点后几位
    /// - Returns: 获取精度后的数据
    func precisionStringWith(count: Int) -> String {
        let format = NumberFormatter()
        format.minimumFractionDigits = 0
        format.maximumFractionDigits = count
        format.roundingMode = .halfUp
        let str = format.string(for: self)
        return str ?? ""
    }
    
    /// 取精度
    /// - Parameter precision: 精度字符串，如0.000001
    /// - Returns: 获取精度后的数据
    func precisionStringWith(precision: String) -> String {
        let count = precision.precision
        return precisionStringWith(count: count)
    }
}
