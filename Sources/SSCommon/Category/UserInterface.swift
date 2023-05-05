//
//  UserInterface.swift
//  SSCommon
//
//  Created by zhtg on 2023/5/5.
//

#if os(iOS)

import UIKit
import Combine

public let kMainScreenRatio = UIScreen.main.bounds.size.height / UIScreen.main.bounds.size.width

public func userInterfacePublisher() -> AnyPublisher<Bool, Never> {
    let observer = ObserverView.shared
    let publisher = observer.publisher
    publisher.send(observer.isDark)
    return publisher.eraseToAnyPublisher()
}

public var isDark: Bool {
    return ObserverView.shared.isDark
}

private class ObserverView: UIView {

    static let shared = ObserverView()

    var publisher = CurrentValueSubject<Bool, Never>(false)
    var isDark: Bool = false {
        didSet {
            publisher.send(isDark)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isDark = traitCollection.userInterfaceStyle == .dark
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        isDark = traitCollection.userInterfaceStyle == .dark
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        isDark = traitCollection.userInterfaceStyle == .dark
    }
}

#endif
