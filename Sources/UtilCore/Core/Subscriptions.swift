//
//  NSObjectSubscription.swift
//  GoodMood
//
//  Created by zhtg on 2023/4/22.
//  Copyright © 2023 hst. All rights reserved.
//

import Foundation

#if canImport(ObjectiveC) && canImport(Combine)
import ObjectiveC
import Combine

private var NSObjectSubscribersSetKey = 0
private var NSObjectSubscriptionKey = 0

public extension AnyPublisher where Failure == Never {
    func onceSink(receiveValue: @escaping (Output) -> Void) {
        var subcription: AnyCancellable?
        subcription = sink(receiveValue: { out in
            receiveValue(out)
            if let subcription {
                SharedSubcriptions.shared.subscriptionSet.remove(subcription)
            }
        })
        subcription?
        .store(in: &SharedSubcriptions.shared.subscriptionSet)
    }
    
}

class SharedSubcriptions: NSObject {
    static let shared = SharedSubcriptions()
}

@available(iOS 13.0, *)
public extension NSObject {
    
    /// 保存单个可取消的订阅
    var subscription: AnyCancellable? {
        get {
            objc_getAssociatedObject(self, &NSObjectSubscriptionKey) as? AnyCancellable
        }
        set {
            objc_setAssociatedObject(self, &NSObjectSubscriptionKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 保存一组订阅的集合
    var subscriptionSet: Set<AnyCancellable> {
        get {
            // 这里用问号判断会崩溃，用感叹号倒可以，果然人不能太好说话，要不然系统都欺负你，必须给他强硬些，让他怕
            if let obj = objc_getAssociatedObject(self, &NSObjectSubscribersSetKey) {
                let set = obj as! Set<AnyCancellable>
                return set
            }
            let set = Set<AnyCancellable>()
            objc_setAssociatedObject(self, &NSObjectSubscribersSetKey, set, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return set
        }
        set {
            objc_setAssociatedObject(self, &NSObjectSubscribersSetKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

#endif
