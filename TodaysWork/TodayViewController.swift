//
//  TodayViewController.swift
//  TodaysWork
//
//  Created by Илалов Андрей on 21/11/2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var littleCircleView: CircleView!
    @IBOutlet weak var typeButton: UIButton!
    
    var timer = Timer()
    
    var percent = 0.0
    var currentDate = Date.timeIntervalSinceReferenceDate
    var lastDate: Double = UserDefaults.standard.double(forKey: "lastDate")
    var isContinue: Bool = false
    
    static let workingHours = 520.0 * 60.0
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        typeButton.setTitleColor(UIColor(red: 154.0/255, green: 194.0/255, blue: 197.0/255, alpha: 1.0), for: .normal)
        
        if lastDate == 0 {
            lastDate = Date.timeIntervalSinceReferenceDate
        }
        littleCircleView.backgroundColor = view.backgroundColor
        
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(doOnTimer), userInfo: nil, repeats: true)
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    @IBAction func typeButtonPress(_ sender: Any) {
        self.lastDate = UserDefaults.standard.double(forKey: "lastDate")
    }
    
    @objc func doOnTimer() {
        let timeInterval = Date.timeIntervalSinceReferenceDate - lastDate
        percent = timeInterval/TodayViewController.workingHours
        littleCircleView.drawAPercentCircle(percent: percent)
        let seconds = round((1-percent) * TodayViewController.workingHours)
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60
        
        
        let str = minutes/10 >= 1 ? String(format: "%d:%d", hours, minutes) : String(format: "%d:0%d", hours, minutes)
        
        typeButton.setTitle(str, for: .normal)
    }
    
}
