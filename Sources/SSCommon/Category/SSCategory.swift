//
//  SSCommon.swift
//  Pods
//
//  Created by shutut on 2021/7/28.
//

import Foundation
#if os(iOS)
import UIKit
#endif

public extension Dictionary {
    var jsonStr: String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            let str = String(data: data, encoding: .utf8)
            return str
        }
        return nil
    }
    
    func stringFor(_ key: String) -> String? {
        let dic = self as! [String: Any]
        if let value = dic[key] {
            if value is String {
                return value as? String
            }
            return "\(value)"
        }
        return nil
    }
    
    func boolFor(_ key: String) -> Bool? {
        let dic = self as! [String: Any]
        if let value = dic[key] {
            if value is Bool {
                return value as? Bool
            } else if value is String {
                return Int(value as! String) ?? 0 > 0
            } else if value is Int {
                return Int(value as! Int) > 0
            }
        }
        return nil
    }
    
    func intFor(_ key: String) -> Int? {
        let dic = self as! [String: Any]
        if let value = dic[key] {
            if value is Int {
                return value as? Int
            } else if value is String {
                return Int(value as! String)
            } else if value is Double {
                return Int(value as! Double)
            }
        }
        return nil
    }
    
    func doubleFor(_ key: String) -> Double? {
        let dic = self as! [String: Any]
        if let value = dic[key] {
            if value is Double {
                return value as? Double
            } else if value is String {
                return Double(value as! String)
            } else if value is Int {
                return Double(value as! Int)
            }
        }
        return nil
    }
    
    func arrayFor(_ key: String) -> [Any]? {
        let dic = self as! [String: Any]
        if let value = dic[key] {
            if value is [Any] {
                return value as? [Any]
            }
        }
        return nil
    }
    
    
    /// json转成对象
    /// - Returns: 返回转成的对象
    func transformToModel<T: Decodable>(_ type: T.Type) -> T? {
        let data: Data
        
        do {
            data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        } catch {
            print("\(self)转成Data失败：\(error)")
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch {
            print("\(self)转成\(type)失败：\(error)")
        }
        
        return nil
    }
}

public extension Encodable {
    
    /// 对象转成json字典
    /// - Returns: 返回转成的json
    func transformToJson() -> [String: Any]? {
        let data: Data
        do {
            let encoder = JSONEncoder()
            data = try encoder.encode(self)
        } catch {
            print("\(self)转成data失败：\(error)")
            return nil
        }
        
        do {
            let json =  try JSONSerialization.jsonObject(with: data, options: [.mutableLeaves, .mutableContainers]) as? [String: Any]
            return json
        } catch {
            print("data转成json失败：\(error)")
        }
        
        return nil;
    }
}

public extension Array where Element == [String: Any] {
    func transformToModelArray<T: Decodable>(_ type: T.Type) -> [T]? {
        var arr = [T]()
        for dic in self {
            if let model = dic.transformToModel(type) {
                arr.append(model)
            }
        }
        if arr.count > 0 {
            return arr
        }
        return nil
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
    
    var doubleValue: Double? {
        return Double(self)
    }
}

public extension Double {
    var stringValue: String? {
        return "\(self)"
    }
}

public extension String {
    /// 取精度
    /// - Parameter count: 小数点后几位
    /// - Returns: 获取精度后的数据
    func precisionStringWith(count: Int) -> String {
        let sz = self
        let arr = sz.components(separatedBy: ".")
        if arr.count != 2 {
            return sz
        }
        if count == 0 {
            return arr.first!
        }
        let first = arr.first
        var last = arr.last
        if last!.count > count {
            last = "\(last!.prefix(count))"
        }
        let newStr = "\(first!).\(last!)"
        return newStr
    }
    
    /// 取精度
    /// - Parameter precision: 精度字符串，如0.000001
    /// - Returns: 获取精度后的数据
    func precisionStringWith(precision: String) -> String {
        var newPre = precision
        while newPre.hasSuffix("0") {
            newPre = "\(newPre.prefix(newPre.count - 2))"
        }
        let arr = newPre.components(separatedBy: ".")
        if arr.count == 1 {
            return precisionStringWith(count: 0)
        }
        let str = arr.last
        return precisionStringWith(count: str!.count)
    }
    
    func urlEncodeString() -> String? {
        let characters = "!*'();:@&=+$,/?%#[]"
        let set = CharacterSet(charactersIn: characters).inverted
        let str = self.addingPercentEncoding(withAllowedCharacters: set)
        return str
    }
}

#if os(iOS)
@objc public extension UIFont {
    @objc class func PingFangSC_UltralightFont(ofSize size: CGFloat) -> UIFont {
        var font = UIFont(name: "PingFangSC-Ultralight", size: size)
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        return font!
    }
    @objc class func PingFangSC_SemiboldFont(ofSize size: CGFloat) -> UIFont {
        var font = UIFont(name: "PingFangSC-Semibold", size: size)
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        return font!
    }
    @objc class func PingFangSC_ThinFont(ofSize size: CGFloat) -> UIFont {
        var font = UIFont(name: "PingFangSC-Thin", size: size)
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        return font!
    }
    @objc class func PingFangSC_LightFont(ofSize size: CGFloat) -> UIFont {
        var font = UIFont(name: "PingFangSC-Light", size: size)
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        return font!
    }
    @objc class func PingFangSC_MediumFont(ofSize size: CGFloat) -> UIFont {
        var font = UIFont(name: "PingFangSC-Medium", size: size)
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        return font!
    }
    @objc class func PingFangSC_RegularFont(ofSize size: CGFloat) -> UIFont {
        var font = UIFont(name: "PingFangSC-Regular", size: size)
        if font == nil {
            font = UIFont.systemFont(ofSize: size)
        }
        return font!
    }
}

@objc public extension UIImage {
    
    /// 得到一个原始的图片，不经过渲染，用于button的image，或者bar的image这些地方，系统会自动重渲染这些图标，可以有效防止系统重渲染
    /// - Returns: 返回原始的图片
    @objc func originalImage() -> UIImage {
        let im = self.withRenderingMode(.alwaysOriginal)
        return im
    }
}

@objc public extension UIView {
    
    var left: CGFloat {
        set {
            var fr = frame
            fr.origin.x = newValue
            frame = fr
        }
        get {
            frame.origin.x
        }
    }
    
    var top: CGFloat {
        set {
            var fr = frame
            fr.origin.y = newValue
            frame = fr
        }
        get {
            frame.origin.y
        }
    }
    
    var right: CGFloat {
        set {
            var fr = frame
            fr.origin.x = newValue - fr.size.width
            frame = fr
        }
        get {
            frame.maxX
        }
    }
    
    var bottom: CGFloat {
        set {
            var fr = frame
            fr.origin.y = newValue - fr.size.height
            frame = fr
        }
        get {
            frame.maxY
        }
    }
    
    var width: CGFloat {
        set {
            var fr = frame
            fr.size.width = newValue
            frame = fr
        }
        get {
            frame.size.width
        }
    }
    
    var height: CGFloat {
        set {
            var fr = frame
            fr.size.height = newValue
            frame = fr
        }
        get {
            frame.size.height
        }
    }
    
    var centerX: CGFloat {
        set {
            var cen = center
            cen.x = newValue
            center = cen
        }
        get {
            center.x
        }
    }
    
    var centerY: CGFloat {
        set {
            var cen = center
            cen.y = newValue
            center = cen
        }
        get {
            center.y
        }
    }
}
#endif
