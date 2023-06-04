//
//  Task.swift
//  NetService
//
//  Created by zhtg on 2023/5/13.
//

import Foundation

public extension Task where Failure == Error {
    @discardableResult
    init(priority: TaskPriority? = nil,
         operation: @escaping @Sendable () async throws -> Success,
         catch: @escaping @Sendable (Error) -> Void) {
        self.init(priority: priority) {
            do {
                return try await operation()
            }
            catch {
                `catch`(error)
                throw error
            }
        }
    }
}
