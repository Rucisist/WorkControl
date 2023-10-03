//
//  OnMain.swift
//  WorkControll
//
//  Created by Андрей Илалов on 03.10.2023.
//  Copyright © 2023 Андрей Илалов. All rights reserved.
//

import Foundation

/// Выполняет блок синхронно и на главном потоке. Можно вызывать и с главного потока - безопасно.
/// - Parameter block: Блок, который будет выполнен на главном потоке.
public func executeOnMainThread(_ block: () -> Void) {
    guard !Thread.current.isMainThread else {
        block()
        return
    }

    DispatchQueue.main.sync {
        block()
    }
}
