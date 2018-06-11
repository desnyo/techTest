//
//  Restaurant.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

class Restaurant {
    var location: Location?
    var name: String?
    var imageUrl: URL?
    var cuisine: String?
    var rating: Double?
    var reviews: [Review]?
    
    init(json: JSON) {
        if let lat = json["geometry"]["location"]["lat"].double, let lng = json["geometry"]["location"]["lng"].double {
            let newLocation = Location()
            // TODO: Remove hardcoding
            newLocation.city = "Dubai"
            newLocation.coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            self.location = newLocation
        }
        if let name = json["name"].string {
            self.name = name
        }
        if let rating = json["rating"].double {
            self.rating = rating
        }
        // TODO: Remove hardcoding
        self.imageUrl = URL(string: "https://placekitten.com/200/200")
        self.cuisine = "Chinese"
        self.reviews = [Review(data: NSObject()), Review(data: NSObject()), Review(data: NSObject())]
    }
    
    static func restaurants(data: AnyObject) -> [Restaurant] {
        let json = JSON(data)
        guard let results = json["results"].array else { return [] }
        return results.map { item in
            return Restaurant(json: item)
        }
    }
}
