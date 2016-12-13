//
//  FinalDisplay.swift
//  FoodTracker
//
//  Created by Emily on 12/12/16.
//  Copyright © 2016 Emily. All rights reserved.
//

import UIKit

class FinalDisplay: UIViewController {

    // MARK: Properties
    @IBOutlet weak var textDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textDisplayText: String = makeDisplayText()
        textDisplay.text = textDisplayText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Make text for display.
    func makeDisplayText() -> String {
        var finalString: String = ""
        for i in glucoseTimes.keys {
            //let glucose = glucoseEntries[i]
            let cal = glucoseTimes[i]
            let dateTime = formatDateTime(dt: cal!)
            finalString = finalString+"\n"+dateTime
        }
        //return "String\nString!"
        return finalString
    }
    
    func formatDateTime(dt: Date) -> String{
        let calendar = Calendar.current
        let second = String(format: "%02d", calendar.component(.second, from: dt))
        let hour = String(format: "%02d", calendar.component(.hour, from: dt)%12)
        let minute = String(format: "%02d", calendar.component(.minute, from: dt))
        return("\(hour):\(minute):\(second)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
