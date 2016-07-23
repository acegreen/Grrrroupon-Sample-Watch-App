//
//  TableRowType.swift
//  Chronic
//
//  Created by Ace Green on 2015-05-09.
//  Copyright (c) 2015 Ace Green. All rights reserved.
//

import WatchKit
import Foundation

class TableRowPrototype: NSObject {
    
    @IBOutlet var mainImage: WKInterfaceImage!
    
    @IBOutlet var mainTitle: WKInterfaceLabel!
    
    @IBOutlet var rating: WKInterfaceLabel!
    
    @IBOutlet var distance: WKInterfaceLabel!
    
    @IBOutlet var previousPrice: WKInterfaceLabel!
    
    @IBOutlet var currentPrice: WKInterfaceLabel!
    
}
