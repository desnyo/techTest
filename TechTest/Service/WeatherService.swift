//
//  WeatherService.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

// Example request: https://api.darksky.net/forecast/287007381346d72dac7172e2e3c49472/47.5,19.05

class WeatherService: WeatherServiceProtocol {
    static let shared = WeatherService()
    
    private let urlPrefix = "https://api.darksky.net/forecast/"
    private let apiKey = "287007381346d72dac7172e2e3c49472"

    func getWeather(coordinate: CLLocationCoordinate2D, onComplete: @escaping ((Weather) -> Void)) {
        if let url = self.url(coordinate: coordinate) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil,let usableData = data as AnyObject? {
                    onComplete(Weather(data: usableData))
                }
            }
            task.resume()
        }
    }
    
    private func url(coordinate: CLLocationCoordinate2D) -> URL? {
        let string = urlPrefix + apiKey + "/" + String(coordinate.latitude) + "," + String(coordinate.longitude)
        return URL(string: string)
    }
}
