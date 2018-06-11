//
//  WeatherViewModelTests.swift
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

class WeatherViewModelTests: XCTestCase {
    let viewModel = WeatherViewModel(locationService: LocationServiceMock.shared, weatherService: WeatherServiceMock.shared)
    let testCoordinate = CLLocationCoordinate2D(latitude: 12.3, longitude: 45.6)
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRefreshWeather() {
        let newLocation = Location()
        newLocation.coordinates = testCoordinate
        viewModel.location = newLocation
        viewModel.refreshWeather()
        expect(WeatherServiceMock.shared.didGetWeather).to(beTrue())
        expect(WeatherServiceMock.shared.requestCoordinate?.latitude).to(equal(testCoordinate.latitude))
        expect(WeatherServiceMock.shared.requestCoordinate?.longitude).to(equal(testCoordinate.longitude))
    }
    
    func testRefreshWeatherFail() {
        viewModel.location?.coordinates = nil
        WeatherServiceMock.shared.didGetWeather = false
        viewModel.refreshWeather()
        expect(WeatherServiceMock.shared.didGetWeather).to(beFalse())
    }
    
    func testLocationUpdate() {
        let newLocation = Location()
        newLocation.coordinates = testCoordinate
        LocationServiceMock.shared.location.value = newLocation
        expect(self.viewModel.location?.coordinates?.latitude).to(equal(testCoordinate.latitude))
        expect(self.viewModel.location?.coordinates?.longitude).to(equal(testCoordinate.longitude))
    }
    
}
