//
//  DeveloperVC.swift
//  WorkControll
//
//  Created by Андрей Илалов on 25.09.2020.
//  Copyright © 2020 Андрей Илалов. All rights reserved.
//

import Foundation
import UIKit

class DeveloperVC: UIViewController {
    let versionNumber: Int
    let versionNumberLabel: UILabel = .init()
    
    init(versionNumber: Int) {
        self.versionNumber = versionNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        versionNumberLabel.frame = view.frame
    }
}

extension DeveloperVC {
    @objc func doWhenTappedToScreen() {
        UserDefaults.standard.set(versionNumber, forKey: "versionNumber")
    }
}

fileprivate extension DeveloperVC {
    func setupUI() {
        view.addSubview(versionNumberLabel)
        versionNumberLabel.font = .systemFont(ofSize: 20)
        versionNumberLabel.textColor = .black
        
        versionNumberLabel.text = "\(versionNumber)"
        
        let gestureRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(doWhenTappedToScreen))
        gestureRecognizer.minimumPressDuration = 3.0
        
        versionNumberLabel.frame = view.frame
    }
}
