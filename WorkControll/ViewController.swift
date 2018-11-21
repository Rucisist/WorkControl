//
//  ViewController.swift
//  WorkControll
//
//  Created by Андрей Илалов on 20.11.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var satrtButton: UIButton!
    
    @IBOutlet weak var circleView: CircleView!
    var timer = Timer()
    
    var percent = 0.0
    var currentDate = Date.timeIntervalSinceReferenceDate
    var lastDate: Double = UserDefaults.standard.double(forKey: "lastDate")
    var isContinue: Bool = false
    
    static let workingHours = 520.0 * 60.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if lastDate == 0 {
            lastDate = Date.timeIntervalSinceReferenceDate
        }
        circleView.backgroundColor = view.backgroundColor
        
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(doOnTimer), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startButtonTapped(_ sender: Any) {
        lastDate = Date.timeIntervalSinceReferenceDate
        UserDefaults.standard.set(lastDate, forKey: "lastDate")
    }
    
    @objc func doOnTimer() {
        let timeInterval = Date.timeIntervalSinceReferenceDate - lastDate
        percent = timeInterval/ViewController.workingHours
        circleView.drawAPercentCircle(percent: percent)
        let seconds = round((1-percent) * ViewController.workingHours)
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60
        
        
        let str = minutes/10 >= 1 ? String(format: "%d:%d", hours, minutes) : String(format: "%d:0%d", hours, minutes)
        
        satrtButton.setTitle(str, for: .normal)
    }
    
}

