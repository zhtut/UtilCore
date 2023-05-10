//
//  UIView.swift
//  Pods
//
//  Created by zhtg on 2023/5/10.
//

#if os(iOS)

import UIKit

public extension UIView {
    var viewController: UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.viewController
        } else {
            return nil
        }
    }
}

#endif
