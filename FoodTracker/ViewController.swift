//
//  ViewController.swift
//  FoodTracker
//
//  Created by Emily on 10/11/16.
//  Copyright © 2016 Emily. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mealNameLabel: UILabel!
    //@IBOutlet weak var headerLabel: UINavigationBar!
    @IBOutlet weak var navigationHeader: UIBarButtonItem!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Handle the text field's user input through delegate callbacks.
        // Might need this again later? But for now just breaks stuff
        //nameTextField.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // This is what we'd have the app do
        // after the person hits "return" from the keyboard
        // right now we want that to be nothing.
    }
    
    // MARK: Actions
    @IBAction func forgotButton(_ sender: AnyObject) {
        // Save an NA or something
        // Move to next page
        // Pop-up saying "are you sure?"
        let alertController = UIAlertController(title: "Confirm", message: "Leave this measurement empty?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel,handler: nil))
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler:  {action in self.saveSkippedMeasurement()}))
        self.present(alertController, animated:true, completion:nil)
    }
    
    func saveSkippedMeasurement(){
        print("Skipping...")
        glucoseEntries[mealNumber] = nil
        glucoseTimes[mealNumber] = Date()
        mealNumber = mealNumber+1
        self.performSegue(withIdentifier: "segueOne", sender: self)
    }
    
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        // Save measurement, date, and time
        // Move to next page
        let alertController = UIAlertController(title: "Confirm", message: "Save entry?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel,handler: nil))
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: {action in self.saveMeasurement()}))
        self.present(alertController, animated:true, completion:nil)
    }
    
    func saveMeasurement(){
        print("Saving...")
        let calendar = Date()
        
        //let measurements = Measurements(day: 1, meal: 1, dateTime: calendar, glucose: 200)
        //saveMeasurements(measurements: measurements!)

        saveMeasurements(dateTime: calendar, glucose: nameTextField.text!)
    }

    // MARK: NSCoding
    //func saveMeasurements(measurements: Measurements){
    func saveMeasurements(dateTime: Date, glucose: String){
        let isSuccessfulSave = isValidGlucose(gluc: glucose)
        
        if !isSuccessfulSave {
            print("Failed to save")
            let failAlertController = UIAlertController(title: "Invalid Glucose Value", message: "Please enter an integer between 20 and 400.", preferredStyle: UIAlertControllerStyle.alert)
            failAlertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel,handler: nil))
            self.present(failAlertController, animated:true, completion:nil)
        }
            
        else {
        print("Saved!")
        glucoseEntries[mealNumber] = glucose
        glucoseTimes[mealNumber] = dateTime
        mealNumber = mealNumber+1
        self.performSegue(withIdentifier: "segueOne", sender: self)
        }
    }
    
    // MARK: check if glucose value is valid
    // Probably should perform this check a bit
    // earlier in the process, but...eh.
    func isValidGlucose(gluc:String)->Bool{
        if let firstTest = Int(gluc) {
            if firstTest < 400 && firstTest > 20 {return(true)}
        }
        return(false)
    }
    
    // This probably doesn't get used anymore
    func loadMeasurements() -> [Measurements]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Measurements.ArchiveURL.path) as? [Measurements]
    }
    
}

