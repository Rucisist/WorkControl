//
//  Router.swift
//  WorkControll
//
//  Created by Андрей Илалов on 25.09.2020.
//  Copyright © 2020 Андрей Илалов. All rights reserved.
//

import Foundation
import UIKit

protocol Routable {
    var from: UIViewController { set get }
    var to: UIViewController { set get }
}


extension UIViewController {
    func show(vc: UIViewController) {
        self.present(vc, animated: true, completion: {
            Animator.animate(view: vc.view)
        })
    }
}
