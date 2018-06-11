//
//  Weather.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation

enum WeatherType {
    case sunny
    case sunnyWithCloud
    case clouds
    case fog
    case rain
    case snow
}

class Weather {
    var location: Location?
    var currentTemperature: UnitTemperature?
    var type: WeatherType?
    var precipation: Double?
    var humidity: Double?
    var wind: Double?
    var forecast: [DailyWeather]?
    
    init(data: AnyObject) {
    }
}
