//
//  Animator.swift
//  WorkControll
//
//  Created by Илалов Андрей on 01.10.2020.
//  Copyright © 2020 Андрей Илалов. All rights reserved.
//

import Foundation
import UIKit

class Animator: NSObject {
    static func animate(view: UIView) {
        view.alpha = 0
        UIView.animate(withDuration: 0.2) {
            view.alpha = 1
        }
    }
}
