//
//  RestaurantViewModelTests.swift
//  TechTestTests
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation

import XCTest
import Nimble

import CoreLocation

@testable import TechTest

class RestaurantViewModelTests: XCTestCase {
    let viewModel = RestaurantViewModel(locationService: LocationServiceMock.shared, restaurantService: RestaurantServiceMock.shared)
    let testCoordinate = CLLocationCoordinate2D(latitude: 12.3, longitude: 45.6)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRefreshRestaurants() {
        let newLocation = Location()
        newLocation.coordinates = testCoordinate
        viewModel.location = newLocation
        viewModel.refreshRestaurants()
        expect(RestaurantServiceMock.shared.didGetRestaurants).to(beTrue())
        expect(RestaurantServiceMock.shared.requestCoordinate?.latitude).to(equal(testCoordinate.latitude))
        expect(RestaurantServiceMock.shared.requestCoordinate?.longitude).to(equal(testCoordinate.longitude))
    }
    
    func testRefreshWeatherFail() {
        viewModel.location?.coordinates = nil
        RestaurantServiceMock.shared.didGetRestaurants = false
        viewModel.refreshRestaurants()
        expect(RestaurantServiceMock.shared.didGetRestaurants).to(beFalse())
    }
    
    func testLocationUpdate() {
        let newLocation = Location()
        newLocation.coordinates = testCoordinate
        LocationServiceMock.shared.location.value = newLocation
        expect(self.viewModel.location?.coordinates?.latitude).to(equal(testCoordinate.latitude))
        expect(self.viewModel.location?.coordinates?.longitude).to(equal(testCoordinate.longitude))
    }
    
}
