//
//  LocationServiceMock.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation
import RxSwift

class LocationServiceMock: LocationServiceProtocol {
    static let shared = LocationServiceMock()

    var location = Variable<Location?>(nil)
}
