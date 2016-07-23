//
//  InterfaceController.swift
//  Grrroupon WatchKit Extension
//
//  Created by Ace Green on 2/13/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import WatchKit
import Foundation


class NearbyInterfaceController: WKInterfaceController {
    
    var plistContent: NSArray!
    var nearbyDeals: [Deal] = []
    
    @IBOutlet var NearbyTable: WKInterfaceTable!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let NearbyPrefsFile: NSURL = NSBundle.mainBundle().URLForResource("Nearby_Item_List", withExtension: "plist")!
        plistContent = NSArray(contentsOfURL: NearbyPrefsFile)!
    
        loadTableData()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadTableData() {
        
        self.NearbyTable.setNumberOfRows(plistContent.count, withRowType: "nearbyTableCell")
        
        for (index, item) in plistContent.enumerate() {
            
            let itemDictionary = item as! NSDictionary
            
            let deal = Deal(title: itemDictionary.valueForKey("title") as? String, title2: itemDictionary.valueForKey("title2") as? String, shortDescription: itemDictionary.valueForKey("description") as? String, image: UIImage(named: (itemDictionary.valueForKey("image") as! String)), business: (itemDictionary.valueForKey("business") as? String), address: (itemDictionary.valueForKey("address") as? String), previousPrice: itemDictionary.valueForKey("previousPrice") as! Int, currentPrice: itemDictionary.valueForKey("currentPrice") as! Int, rating: itemDictionary.valueForKey("rating") as? String, distance: itemDictionary.valueForKey("distance") as? String, expiry: itemDictionary.valueForKey("expiry") as? String, location: itemDictionary.valueForKey("location") as? NSDictionary)
            
            nearbyDeals.append(deal)
            
            let row = self.NearbyTable.rowControllerAtIndex(index) as! TableRowPrototype
            
            row.mainTitle.setText(deal.title)
            row.mainImage.setImage(deal.image)
            
            let attributedString = NSAttributedString(string: deal.stringifyPriceWith$(deal.previousPrice), attributes: [NSStrikethroughStyleAttributeName: NSNumber(integer: NSUnderlineStyle.StyleSingle.rawValue)])
            
            row.previousPrice.setAttributedText(attributedString)
            row.currentPrice.setText(deal.stringifyPriceWith$(deal.currentPrice))
            row.rating.setText(deal.rating)
            row.distance.setText(deal.distance)
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        
        self.presentControllerWithNames(["DealInterfaceController1", "DealInterfaceController2", "DealInterfaceController3", "DealInterfaceController4"], contexts: [nearbyDeals[rowIndex],nearbyDeals[rowIndex],nearbyDeals[rowIndex],nearbyDeals[rowIndex]])
        
    }
}
