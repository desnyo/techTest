//
//  RestaurantServiceMock.swift
//  TechTestTests
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation
import CoreLocation

class RestaurantServiceMock: RestaurantServiceProtocol {
    static let shared = RestaurantServiceMock()
    
    var didGetRestaurants = false
    var requestCoordinate: CLLocationCoordinate2D?
    var mockRestaurants = [Restaurant]()
    
    func getRestaurants(coordinate: CLLocationCoordinate2D, onComplete: @escaping (([Restaurant]) -> Void)) {
        didGetRestaurants = true
        requestCoordinate = coordinate
        onComplete(self.mockRestaurants)
    }
}
