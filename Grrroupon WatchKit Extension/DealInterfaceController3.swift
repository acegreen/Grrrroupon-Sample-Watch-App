//
//  DealDetailInterfaceController.swift
//  Grrroupon WatchKit Extension
//
//  Created by Ace Green on 2/13/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import WatchKit
import Foundation


class DealInterfaceController3: WKInterfaceController {
    
    var context: Deal?
    
    @IBOutlet var distance: WKInterfaceLabel!
    
    @IBOutlet var business: WKInterfaceLabel!
    
    @IBOutlet var address: WKInterfaceLabel!
    
    @IBOutlet var map: WKInterfaceMap!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    
        self.context = context as? Deal
        loadContextData(self.context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadContextData(context: Deal?) {
        
        guard context != nil else { return }
            
        distance.setText(context!.distance)
        business.setText(context!.business)
        address.setText(context!.address)
        
        if let location = context!.location as? NSDictionary {
            
            let lat = location.valueForKey("lat") as! Double
            let long = location.valueForKey("long") as! Double
            
            // Load map
            let mapLocation:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let coordinateSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            self.map.addAnnotation(mapLocation, withPinColor: WKInterfaceMapPinColor.Green)
            self.map.setRegion(MKCoordinateRegion(center: mapLocation, span: coordinateSpan))
        }
    }
}
