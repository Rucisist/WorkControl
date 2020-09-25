//
//  ViewController.swift
//  WorkControll
//
//  Created by Андрей Илалов on 20.11.2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

import UIKit

struct People {
    let uid: String
    let name: String
    init(uid: String, name: String) {
        self.uid = uid
        self.name = name
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var satrtButton: UIButton!
    
    @IBOutlet weak var labelTo: UILabel!
    @IBOutlet weak var labelFrom: UILabel!
    @IBOutlet weak var circleView: CircleView!
    
    fileprivate var longGestureRecognizer: UILongPressGestureRecognizer?
    
    var timer = Timer()
    
    var percent = 0.0
    
    var people: [People] = [People(uid: "1886275", name: "Андрей Илалов"), People(uid: "235", name: "Денчик Кириллов"), People(uid: "100", name: "Паша Жарчинский"), People(uid: "275", name: "Антон Попов")]
    
    var currentDate = Date.timeIntervalSinceReferenceDate
    
    let userDefaults = UserDefaults(suiteName: "group.workApp.me")
    
    var lastDate: Double = UserDefaults.standard.double(forKey: "lastDate")
    
    var isContinue: Bool = false
    
    static let workingHours = 520.0 * 60.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        longGestureRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(doAtLongGesture))
        if let tap = longGestureRecognizer {
            view.addGestureRecognizer(tap)
        }
        pickerView.delegate = self
        pickerView.dataSource = self
        let request = Request()
        request.doRequest(completion: { [weak self] currentd in
            UserDefaults.standard.set(currentd, forKey: "lastDate")
            self?.userDefaults?.set(currentd, forKey: "lastDate")
            
            self?.lastDate = currentd
        }, uid: "1886275")
        
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
    
    
    @IBAction func doOnDeveloperButton(_ sender: Any) {
        let newView = UIView(frame: CGRect.init(origin: CGPoint.init(x: self.view.frame.width / 2 - 50, y: self.view.frame.height / 2 - 50), size: CGSize.init(width: 100, height: 100)))
        
        let devDescriptionLabel: UILabel = UILabel.init(frame: CGRect(x: 10, y: 40, width: 60, height: 20))
        devDescriptionLabel.textColor = .black
        devDescriptionLabel.text = "madeByAIS"
//        newView.addSubview(devDescriptionLabel)
        
        self.show(vc: DeveloperVC.init(versionNumber: UserDefaults.standard.integer(forKey: "versionNumber")))
        
        newView.backgroundColor = .green
        
        view.addSubview(newView)
    }
    
    @IBAction func startButtonTapped(_ sender: Any) {
        let request = Request()
        request.doRequest(completion: { [weak self] currentd in
            UserDefaults.standard.set(currentd, forKey: "lastDate")
            self?.userDefaults?.set(currentd, forKey: "lastDate")
            self?.lastDate = currentd
        }, uid: people[0].uid)
        
    }
    
    @objc func doOnTimer() {
        let timeInterval = Date.timeIntervalSinceReferenceDate - lastDate
        percent = timeInterval/ViewController.workingHours
        circleView.drawAPercentCircle(percent: percent)
        let seconds = round((1-percent) * ViewController.workingHours)
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        labelFrom.text = dateFormatter.string(from: Date(timeIntervalSinceReferenceDate: lastDate))
        
        labelTo.text = dateFormatter.string(from: Date(timeIntervalSinceReferenceDate: lastDate + ViewController.workingHours))
        
        var str = minutes/10 >= 1 ? String(format: "0%d:%d", hours, minutes) : String(format: "0%d:0%d", hours, minutes)
        
        if hours <= 0, minutes <= 0 {
            str = "It's time to go"
        }
        
        satrtButton.setTitle(str, for: .normal)
    }
    
}

extension ViewController:  UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return people.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return people[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        
        let request = Request()
        request.doRequest(completion: { [weak self] currentd in
            UserDefaults.standard.set(currentd, forKey: "lastDate")
            self?.userDefaults?.set(currentd, forKey: "lastDate")
            self?.lastDate = currentd
            }, uid: people[row].uid)
    }
    
}

extension ViewController {
    @objc func doAtLongGesture() {
        let controller = UIAlertController.init(title: "Время", message: "нужно отработать с 9 до 11 15. + 8 часов 40 минут", preferredStyle: .alert)
        present(controller, animated: true, completion: nil)
    }
}
