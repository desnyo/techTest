//
//  Weather.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

enum WeatherType {
    case sunny
    case sunnyWithCloud
    case clouds
    case fog
    case rain
    case snow
}

class Weather {
    var location: CLLocationCoordinate2D?
    var currentTemperature: Measurement<UnitTemperature>?
    var type: WeatherType?
    var precipation: Double?
    var humidity: Double?
    var wind: Double?
    var forecast: [DailyWeather]?
    
    init(data: AnyObject) {
        let json = JSON(data)
        if let lat = json["latitude"].double, let lng = json["longitude"].double {
            self.location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
        if let currentTemperatureFahrenheit = json["currently"]["temperature"].double {
            self.currentTemperature = Measurement(value: currentTemperatureFahrenheit, unit: UnitTemperature.fahrenheit)
        }
    }
}
