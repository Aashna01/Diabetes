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
    let MealNameKey = [ 1: "Day 1 - Before Breakfast",
                        2: "Day 1 - After Breakfast",
                        3: "Day 1 - Before Lunch",
                        4: "Day 1 - After Lunch"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textDisplayText: NSMutableAttributedString = makeDisplayText()
        textDisplay.attributedText = textDisplayText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Make text for display.
    func makeDisplayText() -> NSMutableAttributedString {
        var finalString: String = ""
        var blueLines: [[Int]] = []
        var redLines: [[Int]] = []
        var charCount: Int = 0
        let sortedKeys = glucoseTimes.keys.sorted()
        for i in sortedKeys {
            var tempString: String = ""
            let glucose = glucoseEntries[i]
            let cal = glucoseTimes[i]
            let dateTime = formatDateTime(dt: cal!)
            if glucose != nil {
                tempString = tempString+"\(MealNameKey[i]!)\t\(dateTime)\t\(glucose!)"
            }
            else {
                tempString = tempString+"\(MealNameKey[i]!)\t\(dateTime)\tSkipped"
            }
            let lineCharCount = tempString.characters.count+1
            if glucose == nil {
                blueLines.append([charCount,lineCharCount])
            }
            else if Int(glucose!)! > 185 {
                redLines.append([charCount,lineCharCount])
            }
            finalString = finalString+"\n"+tempString
            charCount = charCount+lineCharCount
        }
 
        let myString = NSMutableAttributedString( string: finalString )
        
        for item in blueLines {
            myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSRange(location:item[0], length:item[1]))
        }
        
        for item in redLines {
            myString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSRange(location:item[0], length:item[1]))
        }
        
        return myString
    }
    
    func formatDateTime(dt: Date) -> String{
        let calendar = Calendar.current
        let second = String(format: "%02d", calendar.component(.second, from: dt))
        //let hour = String(format: "%02d", calendar.component(.hour, from: dt)%12)
        let hour = String(format: "%02d", calendar.component(.hour, from: dt))
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
