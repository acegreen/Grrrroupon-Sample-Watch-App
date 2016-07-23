//
//  Chart.swift
//  Chartinder
//
//  Copyright (c) 2015 Ace Green. All rights reserved.
//


import UIKit

public class Deal: NSObject {
    
    let title: String!
    let title2: String!
    let shortDescription: String!
    let image: UIImage!
    let business: String!
    let address: String?
    
    var previousPrice: Int!
    var currentPrice: Int!
    
    func stringifyPriceWith$(price:Int) -> String {
        return "$\(price)"
    }
    
    let rating: String?
    let distance: String?
    let expiry: String?
    
    let location:NSDictionary!
    
    var searchDescription: String {
        return "\(title)\nRating: \(rating)\nDistance: \(distance)"
    }
    
    init(title: String!, title2: String!, shortDescription: String!, image: UIImage!, business: String!, address: String?, previousPrice: Int, currentPrice: Int, rating: String?, distance: String?, expiry: String?, location: NSDictionary!) {
        
        self.title =  title
        self.title2 =  title2
        self.shortDescription = shortDescription
        self.image = image
        self.business = business
        self.address = address
        self.previousPrice = previousPrice
        self.currentPrice = currentPrice
        
        self.rating = rating
        self.distance = distance
        self.expiry = expiry
    
        self.location = location
    }
}