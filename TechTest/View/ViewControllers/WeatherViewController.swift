//
//  WeatherViewController.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import UIKit
import RxSwift

class WeatherViewController: UIViewController {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
        
    let viewModel = WeatherViewModel(locationService: ServiceConfiguration.shared.location, weatherService: ServiceConfiguration.shared.weather)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func addBindings() {
        // TODO: Add error handling and loading animation
        viewModel.city.subscribe(onNext: { (city) in
            if let city = city {
                self.cityNameLabel.text = city
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)

        viewModel.degrees.subscribe(onNext: { (degrees) in
            if let degrees = degrees {
                self.degreeLabel.text = degrees
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
}

