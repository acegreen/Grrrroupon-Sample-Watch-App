//
//  Funtions.swift
//  StockSwipe
//
//  Created by Ace Green on 2015-03-28.
//  Copyright (c) 2015 Ace Green. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import CoreSpotlight
import MobileCoreServices
import SystemConfiguration
import WatchConnectivity

public class Functions {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags.ConnectionAutomatic
        
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    @available(iOS 9.0, *)
    class func createNSUserActivity(deal: Deal, uniqueIdentifier: String, domainIdentifier: String) {
        
        let attributeSet:CSSearchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        attributeSet.contentDescription = deal.searchDescription
        //    attributeSet.thumbnailData = image
        //    attributeSet.relatedUniqueIdentifier = title
        
        let activity = NSUserActivity(activityType: domainIdentifier)
        activity.title = deal.title
        activity.keywords = NSSet(array: [deal.title, deal.business, deal.searchDescription, "Deal", "Grrroupon"]) as! Set<String>
        activity.userInfo = ["title": deal.title, "business": deal.business, "searchDescription": deal.searchDescription]
        activity.contentAttributeSet = attributeSet
        
        activity.requiredUserInfoKeys = NSSet(array: ["symbol", "companyName", "searchDescription"]) as! Set<String>
        activity.eligibleForSearch = true
        activity.eligibleForPublicIndexing = true
        let nsUserActivityArray = [activity]
        activity.becomeCurrent()
        
        print("NSUserActivity created")
    }
    
    @available(iOS 9.0, *)
    class func addToSpotlight(deal: Deal, uniqueIdentifier: String, domainIdentifier: String) {
        
        let attributeSet:CSSearchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeImage as String)
        attributeSet.title = deal.title
        attributeSet.contentDescription = deal.searchDescription
        attributeSet.thumbnailData = nil
        attributeSet.keywords = [deal.title, deal.business, deal.searchDescription, "Deal", "Grrroupon"]
        
        let searchableItem = CSSearchableItem(uniqueIdentifier: uniqueIdentifier, domainIdentifier: domainIdentifier, attributeSet: attributeSet)
        
        CSSearchableIndex.defaultSearchableIndex().indexSearchableItems([searchableItem]) { (error) -> Void in
            
            if let error = error {
                print("Deindexing error: \(error.localizedDescription)")
            } else {
                print("Search item successfully indexed!")
            }
        }
        
    }
    
    @available(iOS 9.0, *)
    class func deleteFromSpotlight(uniqueIdentifier: String) {
        
        CSSearchableIndex.defaultSearchableIndex().deleteSearchableItemsWithIdentifiers([uniqueIdentifier]) { (error: NSError?) -> Void in
            
            if let error = error {
                print("Deindexing error: \(error.localizedDescription)")
            } else {
                print("Search item successfully removed!")
            }
        }
    }
    
    @available(iOS 9.0, *)
    class func sendContextToAppleWatch(wcSession: WCSession, context: AnyObject) {
        
        guard (WCSession.isSupported()) else {
            
            return
        }
        
        guard wcSession.paired && wcSession.watchAppInstalled else {
            return
        }
        
        do {
            
            try wcSession.updateApplicationContext(context as! [String : AnyObject])
            
            print("Context sent")
            
        } catch let error as NSError {

            print("Updating the context failed: " + error.localizedDescription)
        } catch {
            print("i dunno")
        }
    }
    
    class func displayAlert (title: String, message: String, Action1:UIAlertAction?, Action2:UIAlertAction?) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        if Action1 != nil {
            
            alert.addAction(Action1!)
        }
        
        if Action2 != nil {
            
            alert.addAction(Action2!)
        }
        
        return alert
    }
    
    class func getCenterOfView(view: UIView) -> CGPoint {
        
        let bounds:CGRect = view.bounds
        let centerOfView:CGPoint = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds))
        return centerOfView
        
    }
    
    class func presentActivityVC(textToShare: String?, imageToShare: UIImage?, url: NSURL?, sender: AnyObject, vc: UIViewController, completion:(activity: String?, success:Bool, items:[AnyObject]?, error:NSError?) -> Void) {
        
        var objectsToShare: [AnyObject] = []
        
        if textToShare != nil {
            
            objectsToShare.append(textToShare!)
        }
        
        if imageToShare != nil {
            
            objectsToShare.append(imageToShare!)
        }
        
        if url != nil {
            
            objectsToShare.append(url!)
        }
        
        guard objectsToShare.count != 0 else {
            return completion(activity: nil, success: false, items: nil, error: nil)
        }
        
        let excludedActivityTypesArray: NSArray = [
            UIActivityTypePostToWeibo,
            UIActivityTypeAssignToContact,
            UIActivityTypeAirDrop,
        ]
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = excludedActivityTypesArray as? [String]
        
        activityVC.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.Up
        activityVC.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        
        vc.presentViewController(activityVC, animated: true, completion: nil)
        
        activityVC.completionWithItemsHandler = { (activity, success, items, error) in
            print("Activity: \(activity) Success: \(success) Items: \(items) Error: \(error)")
            
            completion(activity: activity, success: success, items: items, error: error)
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
    
    @available(iOS 9.0, *)
    class func addDynamicAction(title: String, subtitle:String?, shortcutIconType: UIApplicationShortcutIconType) {
            
        let type = NSBundle.mainBundle().bundleIdentifier! + ".Dynamic"
        let shortcutIconType = shortcutIconType
        let icon = UIApplicationShortcutIcon(type: shortcutIconType)
        
        let dynamicShortcut = UIApplicationShortcutItem(type: type, localizedTitle: title, localizedSubtitle: subtitle, icon: icon, userInfo: nil)
        UIApplication.sharedApplication().shortcutItems = [dynamicShortcut]
    }
    
    class func xDaysFromNow (numberOfDays: Int) -> NSDate {
        
        let dayComponent: NSDateComponents = NSDateComponents()
        dayComponent.day = numberOfDays
        
        let calendar:NSCalendar = NSCalendar.currentCalendar()
        
        return calendar.dateByAddingComponents(dayComponent, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))!
        
    }
}