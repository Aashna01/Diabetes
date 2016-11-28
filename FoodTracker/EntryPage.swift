//
//  EntryPage.swift
//  FoodTracker
//
//  Created by Emily on 11/27/16.
//  Copyright © 2016 Emily. All rights reserved.
//

import UIKit

// MARK: The Phone Number.
var phoneNumber: String = "XXXXXXXXXX"

class EntryPage: UIViewController {
    
    
    // MARK: Properties
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var cellFieldLabel: UILabel!
    @IBOutlet weak var cellField: UITextField!
    @IBOutlet weak var continueButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "entrySegue" {
            let segueShouldOccur = NSPredicate( format: "SELF MATCHES %@", "^\\d{10}$").evaluate(with: cellField.text)
            if !segueShouldOccur {
                let alertController = UIAlertController(title: "Alert", message: "Please enter a valid ten-digit phone number.", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.cancel,handler: nil))
                self.present(alertController, animated:true, completion:nil)
                return false
            }
        }
        phoneNumber = cellField.text!
        return true
    }
}
