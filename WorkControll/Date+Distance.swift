//
//  Date+Distance.swift
//  WorkControll
//
//  Created by Андрей Илалов on 03.10.2023.
//  Copyright © 2023 Андрей Илалов. All rights reserved.
//

import Foundation

// добавил измерение дистанции по времени
public extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    func differenceBetweenNow() -> TimeInterval {
        return Date() - self
    }
}
