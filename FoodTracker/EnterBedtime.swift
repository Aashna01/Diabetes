//
//  EnterBedtime.swift
//  FoodTracker
//
//  Created by Emily on 12/13/16.
//  Copyright © 2016 Emily. All rights reserved.
//

import UIKit

var bedTime = Date()

class EnterBedtime: UIViewController {

    // MARK: Properties
    @IBOutlet weak var bedtimeWheel: UIDatePicker!
    @IBOutlet weak var bedtimeText: UILabel!
    @IBOutlet weak var bedtimeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func saveDate(_ sender: Any) {
        bedTime = bedtimeWheel.date
        let calendar = Calendar.current
        let hour = String(format: "%02d", calendar.component(.hour, from: bedTime))
        let minute = String(format: "%02d", calendar.component(.minute, from: bedTime))
        print("\(hour):\(minute)")
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
