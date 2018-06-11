//
//  LocationService.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

class LocationService : NSObject, LocationServiceProtocol, CLLocationManagerDelegate {
    static let shared = LocationService()
    
    var location = Variable<Location?>(nil)
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        } else {
            // Location is not shared with the app
            // TODO: Show alert
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location else { return }
        let newLocation = Location()
        newLocation.coordinates = locValue.coordinate
        // TODO: remove hardcoding
        newLocation.city = "Dubai"
        let oldCoordinates = location.value?.coordinates ?? CLLocationCoordinate2D()
        if oldCoordinates.latitude != locValue.coordinate.latitude || oldCoordinates.longitude != locValue.coordinate.longitude {
            self.location.value = newLocation
        }
    }
}
