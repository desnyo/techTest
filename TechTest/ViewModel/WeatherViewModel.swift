//
//  WeatherViewModel.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation
import RxSwift

class WeatherViewModel {
    var city = BehaviorSubject<String?>(value: nil)
    var degrees = BehaviorSubject<String?>(value: nil)
    
    private var formatter = MeasurementFormatter()
    
    var location: Location? {
        didSet {
            if let cityName = location?.city {
                DispatchQueue.main.async {
                    self.city.onNext(cityName)
                }
            }
        }
    }
    
    var weather: Weather? {
        didSet {
            if let temperature = weather?.currentTemperature {
                DispatchQueue.main.async {
                    self.degrees.onNext(self.formatter.string(from: temperature))
                }
            }
        }
    }
}
