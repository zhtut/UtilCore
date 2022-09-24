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
