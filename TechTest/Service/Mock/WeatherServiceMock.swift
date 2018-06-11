//
//  WeatherServiceMock.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherServiceMock: WeatherServiceProtocol {
    static let shared = WeatherServiceMock()

    var didGetWeather = false
    var requestCoordinate: CLLocationCoordinate2D?
    var mockWeather = Weather(data: NSObject())
    
    func getWeather(coordinate: CLLocationCoordinate2D, onComplete: @escaping ((Weather) -> Void)) {
        didGetWeather = true
        requestCoordinate = coordinate
        onComplete(self.mockWeather)
    }
}
