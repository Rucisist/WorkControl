//
//  Request.swift
//  WorkControll
//
//  Created by Илалов Андрей on 21/11/2018.
//  Copyright © 2018 Андрей Илалов. All rights reserved.
//

import Foundation

class Request {
    // Set the URL the request is being made to.
    
    func doRequest(completion: @escaping((Double) -> ()), uid: String) {
        var currentDateHelper = Calendar.current.dateComponents(in: TimeZone.init(secondsFromGMT: -3)!, from: Date())
        let month = currentDateHelper.month!
        let year = currentDateHelper.year!
        let str = String(format: "http://cportal.lan/api/late?uid=%@&month=%d&year=%d", uid, month, year)
        let url = URL(string: str)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let dataString = String(data: data, encoding: String.Encoding.utf8)
                    let filteredString = dataString?.filter({ (c) -> Bool in
                        if c == "\"" {
                            return false
                        } else {
                            return true
                        }
                    })
                    
                    guard let str = filteredString else { return }
                    
                    let someArray = str.split(separator: ",", maxSplits: 100, omittingEmptySubsequences: true)
                    let counting = someArray.count - 3
                    
                    let parsedTime = someArray[counting].split(separator: ":")
                    print(parsedTime[1])
                    print(parsedTime[2])
                    
                    var dateComponents = DateComponents()
                    dateComponents.hour = 12
                    dateComponents.minute = 22
                    
                    var currentDate = Calendar.current.dateComponents(in: TimeZone.init(secondsFromGMT: -3)!, from: Date())
                    currentDate.hour = Int(parsedTime[1])
                    currentDate.minute = Int(parsedTime[2])! + 1
                    print(currentDate)
                    
                    completion((currentDate.date?.timeIntervalSinceReferenceDate)! - 180.0 * 60.0)
                    
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
        // Infinitely run the main loop to wait for our request.
        // Only necessary if you are testing in the command line.
    }
}
