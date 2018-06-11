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
    let disposeBag = DisposeBag()
    
    var location: Location? {
        didSet {
            if let cityName = location?.city {
                DispatchQueue.main.async {
                    self.city.onNext(cityName)
                }
            }
            DispatchQueue.main.async {
                self.refreshWeather()
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
    
    init() {
        LocationService.shared.location.asObservable().subscribe(onNext: { (newLocation) in
            self.location = newLocation
        }, onError: { (error) in
            // TODO: Error handling
        }, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    
    func refreshWeather() {
        guard let location = self.location else { return }
    }
}
