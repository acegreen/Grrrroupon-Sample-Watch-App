//
//  Funtions.swift
//  StockSwipe
//
//  Created by Ace Green on 2015-03-28.
//  Copyright (c) 2015 Ace Green. All rights reserved.
//

import Foundation
import CoreData
import WatchConnectivity

public class Functions {
    
    @available(iOS 9.0, *)
    class func sendContextToAppleWatch(wcSession: WCSession, context: AnyObject) {
        
        guard (WCSession.isSupported()) else {
            
            return
        }
        
        do {
            
            try wcSession.updateApplicationContext(context as! [String : AnyObject])
            
            print("Context sent")
            
        } catch let error as NSError {
            
            NSLog("Updating the context failed: " + error.localizedDescription)
        }
    }
    
    // Random number between low and high range
    class func randomInRange (low: Int, high: Int) -> Int {
        
        var RandomNumber = Int(arc4random_uniform(UInt32(high)))
        RandomNumber = max(RandomNumber, low)
        RandomNumber = min(RandomNumber, high - low)
        
        return RandomNumber
    }
    
    class func degreesToRadians(degrees: Double) -> Double {
        return degrees * (M_PI/180.0)
    }
    
    class func formatTime(date: NSDate) -> String {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .ShortStyle
        
        return formatter.stringFromDate(date)
        
    }
    
    class func xDaysFromNow (numberOfDays: Int) -> NSDate {
        
        let dayComponent: NSDateComponents = NSDateComponents()
        dayComponent.day = numberOfDays
        
        let calendar:NSCalendar = NSCalendar.currentCalendar()
        
        return calendar.dateByAddingComponents(dayComponent, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))!
        
    }
}