//
//  UIFont.swift
//  SSCommon
//
//  Created by zhtg on 2023/4/26.
//

#if os(iOS)

import UIKit

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

#endif
