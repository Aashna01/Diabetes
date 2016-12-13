//
//  EnterBedtime.swift
//  FoodTracker
//
//  Created by Emily on 12/13/16.
//  Copyright © 2016 Emily. All rights reserved.
//

import UIKit
import UserNotifications

var bedTime = Date()

class EnterBedtime: UIViewController,UNUserNotificationCenterDelegate {

    // MARK: Properties
    var isGrantedNotificationAccess: Bool = false
    @IBOutlet weak var bedtimeWheel: UIDatePicker!
    @IBOutlet weak var bedtimeText: UILabel!
    @IBOutlet weak var bedtimeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert,.sound,.badge],
            completionHandler: { (granted,error) in
                self.isGrantedNotificationAccess = granted
        }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: I don't know what the word is to use here. What even is this MARK stuff anyway
    // Saves the entered bedtime.
    @IBAction func saveDate(_ sender: Any) {
        bedTime = bedtimeWheel.date
        
        if isGrantedNotificationAccess{
            let content = UNMutableNotificationContent()
            content.title = "Bedtime Greetings!"
            content.body = "Don't forget to enter your nighttime glucose into GlucoPal!"
            
            //let trigger = UNTimeIntervalNotificationTrigger( timeInterval: 4.0, repeats: false)
            let calendar = Calendar.current
            let components = calendar.dateComponents(in: .current, from: bedTime)
            let relevantComponents = DateComponents(calendar: calendar, timeZone: .current, hour: components.hour, minute: components.minute)
            // Should repeat daily forever. I would like to stop it after three days
            // but that's going to have to end up in "future work"
            let trigger = UNCalendarNotificationTrigger(dateMatching: relevantComponents, repeats: true)
            
            let request = UNNotificationRequest(identifier: "bedtime.message", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
    }
    
    
    // MARK: Delegates
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
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
