//
//  IsRTLImage.swift
//  WorkControll
//
//  Created by Андрей Илалов on 03.10.2023.
//  Copyright © 2023 Андрей Илалов. All rights reserved.
//

import UIKit

public extension UIImageView {

    @objc func rtlFlip() {
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            self.image = image?.imageFlippedForRightToLeftLayoutDirection()
        }
    }

}

public extension UIView {

    /// Flip view horizontally.
    func applyRTLHorizontalFlipIfNeeded() {
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
        }
    }

    /// Flip view vertically.
    func applyRTLVerticalFlipIfNeeded() {
        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
        }
    }
    
 }

public var isRTLLanguage: Bool {
    return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
}
