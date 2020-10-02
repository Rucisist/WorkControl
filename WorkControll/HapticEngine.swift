//
//  HapticEngine.swift
//  WorkControll
//
//  Created by Илалов Андрей on 02.10.2020.
//  Copyright © 2020 Андрей Илалов. All rights reserved.
//

import Foundation
import UIKit

public enum HapticFeedbackStyle: Int {
    case light, medium, heavy
}

@available(iOS 10.0, *)
extension HapticFeedbackStyle {
    var value: UIImpactFeedbackGenerator.FeedbackStyle {
        return UIImpactFeedbackGenerator.FeedbackStyle(rawValue: rawValue)!
    }
}

public enum HapticFeedbackType: Int {
    case success, warning, error
}

extension HapticFeedbackType {
    var value: UINotificationFeedbackGenerator.FeedbackType {
        return UINotificationFeedbackGenerator.FeedbackType(rawValue: rawValue)!
    }
}

public enum Haptic {
    
    case impact(HapticFeedbackStyle)
    case notification(HapticFeedbackType)
    case selection

    // trigger
    public func generate() {
        
        guard #available(iOS 10, *) else { return }

        switch self {
        case .impact(let style):
            let generator = UIImpactFeedbackGenerator(style: style.value)
            generator.prepare()
            generator.impactOccurred()
        case .notification(let type):
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type.value)
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
}
