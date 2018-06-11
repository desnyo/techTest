//
//  RestaurantService.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

// Example request: https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&radius=1000&type=restaurant&key=AIzaSyDxok3yO-_hM9SScuFq6nyeBfYlzNuY56I

class RestaurantService: RestaurantServiceProtocol {
    static let shared = RestaurantService()
    
    private let urlPrefix = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="
    private let urlSuffix = "&radius=500&type=restaurant&key=AIzaSyDxok3yO-_hM9SScuFq6nyeBfYlzNuY56I"
    
    // TODO: Add error handling
    func getRestaurants(coordinate: CLLocationCoordinate2D, onComplete: @escaping (([Restaurant]) -> Void)) {
        if let url = self.url(coordinate: coordinate) {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil,let usableData = data as AnyObject? {
                    onComplete(Restaurant.restaurants(data: usableData))
                }
            }
            task.resume()
        }
    }
    
    private func url(coordinate: CLLocationCoordinate2D) -> URL? {
        let string = urlPrefix + String(coordinate.latitude) + "," + String(coordinate.longitude) + urlSuffix
        return URL(string: string)
    }
}
