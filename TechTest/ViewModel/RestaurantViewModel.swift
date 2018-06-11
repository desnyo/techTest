//
//  RestaurantViewModel.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation
import RxSwift

struct RestaurantViewModelItem {
    var imageURL: URL?
    var name: String?
    var cityName: String?
    var cuisine: String?
    var rating: String?
    var numberOfReviews: String?
}

class RestaurantViewModel {
    var items = BehaviorSubject<[RestaurantViewModelItem]?>(value: nil)
    
    private let disposeBag = DisposeBag()

    private let locationService: LocationServiceProtocol
    private let restaurantService: RestaurantServiceProtocol

    var location: Location? {
        didSet {
            DispatchQueue.main.async {
                self.refreshRestaurants()
            }
        }
    }

    var restaurants: [Restaurant]? {
        didSet {
            if let restaurants = restaurants {
                let newItems : [RestaurantViewModelItem] = restaurants.map { restaurant in
                    var newItem = RestaurantViewModelItem()
                    newItem.cityName = restaurant.location?.city
                    newItem.cuisine = restaurant.cuisine
                    newItem.imageURL = restaurant.imageUrl
                    newItem.name = restaurant.name
                    newItem.numberOfReviews = String(restaurant.reviews?.count ?? 0)
                    newItem.rating = String(restaurant.rating ?? 0)
                    return newItem
                }
                DispatchQueue.main.async {
                    self.items.onNext(newItems)
                }
            }
        }
    }

    init(locationService: LocationServiceProtocol, restaurantService: RestaurantServiceProtocol) {
        self.locationService = locationService
        self.restaurantService = restaurantService

        self.locationService.location.asObservable().subscribe(onNext: { (newLocation) in
            self.location = newLocation
        }, onError: { (error) in
            // TODO: Error handling
        }, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }

    func refreshRestaurants() {
        guard let coordinate = self.location?.coordinates else { return }
        self.restaurantService.getRestaurants(coordinate: coordinate, onComplete: { (restaurants) in
            self.restaurants = restaurants
        })
    }
}
