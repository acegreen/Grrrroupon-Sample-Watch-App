//
//  DealDetailInterfaceController.swift
//  Grrroupon WatchKit Extension
//
//  Created by Ace Green on 2/13/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import WatchKit
import Foundation


class DealInterfaceController5: WKInterfaceController {
    
    var context:Deal?
    
    var quantityNumber: Int = 1
    
    @IBOutlet var quantity: WKInterfaceLabel!
    
    @IBOutlet var card4digits: WKInterfaceLabel!
    
    @IBOutlet var subtotal: WKInterfaceLabel!
    
    @IBOutlet var total: WKInterfaceLabel!
    
    @IBAction func confirmButtonAction() {
        
        
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
        
        subtotal.setText(String(quantityNumber))
        subtotal.setText(context!.stringifyPriceWith$(context!.currentPrice))
        
        let totalPrice = (context!.currentPrice) * (quantityNumber)
        total.setText(String(totalPrice))
    }
}
