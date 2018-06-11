//
//  RestaurantServiceProtocol.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation
import CoreLocation

protocol RestaurantServiceProtocol {
    func getRestaurants(coordinate: CLLocationCoordinate2D, onComplete: @escaping (([Restaurant]) -> Void))
}
