//
//  DealDetailInterfaceController.swift
//  Grrroupon WatchKit Extension
//
//  Created by Ace Green on 2/13/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import WatchKit
import Foundation


class DealInterfaceController4: WKInterfaceController {
    
    var context: Deal?
    
    @IBOutlet var expiryDate: WKInterfaceLabel!
    
    @IBOutlet var currentPrice: WKInterfaceLabel!
    
    @IBAction func buyButtonAction() {
        
        self.pushControllerWithName("DealInterfaceController5", context: self.context)
    }
    
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
            
        expiryDate.setText(context!.expiry)
        currentPrice.setText(context!.stringifyPriceWith$(context!.currentPrice))
    }
}
