//
//  LocationServiceProtocol.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift

protocol LocationServiceProtocol {
    var location: Variable<Location?> { get }
}
