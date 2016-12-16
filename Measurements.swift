//
//  Measurements.swift
//  FoodTracker
//
//  Created by Emily on 11/19/16.
//  Copyright © 2016 Emily. All rights reserved.
//

import UIKit

class Measurements: NSObject, NSCoding {
    // MARK: Properties
    
    var day: Int
    var meal: Int
    var dateTime: Calendar
    var glucose: Int
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("measurements")
    
    // MARK: Types
    struct PropertyKey {
        static let dayKey = "day"
        static let mealKey = "meal"
        static let dateTimeKey = "dateTime"
        static let glucoseKey = "glucose"
    }
    
    // MARK: Initialization
    init?(day: Int, meal: Int, dateTime: Calendar, glucose: Int?){
        self.day = day
        // Meal: 1=pre-breakfast, 2=post-breakfast, etc
        self.meal = meal
        self.dateTime = dateTime
        self.glucose = glucose!
        
        super.init()
        
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(day, forKey: PropertyKey.dayKey)
        aCoder.encode(meal, forKey: PropertyKey.mealKey)
        aCoder.encode(dateTime, forKey: PropertyKey.dateTimeKey)
        aCoder.encode(glucose, forKey: PropertyKey.glucoseKey)
    }
    
    required convenience init?(coder aDecoder:NSCoder){
        let day = aDecoder.decodeObject(forKey: PropertyKey.dayKey) as! Int
        let meal = aDecoder.decodeObject(forKey: PropertyKey.mealKey) as! Int
        let dateTime = aDecoder.decodeObject(forKey: PropertyKey.dateTimeKey) as! Calendar
        let glucose = aDecoder.decodeObject(forKey: PropertyKey.glucoseKey) as? Int
        // Must call designated initializer. What's happening with glucose
        self.init(day: day, meal: meal, dateTime: dateTime, glucose: (glucose)!)
        
    }
}
