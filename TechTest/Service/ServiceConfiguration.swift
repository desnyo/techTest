//
//  ServiceConfiguration.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation

struct ServiceConfiguration {
    static let shared = ServiceConfiguration()
    
    var location: LocationServiceProtocol = LocationService.shared
    var weather: WeatherServiceProtocol = WeatherService.shared
}
