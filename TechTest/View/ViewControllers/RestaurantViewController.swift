//
//  RestaurantViewController.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift

class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = RestaurantViewModel(locationService: ServiceConfiguration.shared.location, restaurantService: ServiceConfiguration.shared.restaurant)
    let disposeBag = DisposeBag()
    
    private var items: [RestaurantViewModelItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func addBindings() {
        // TODO: Add error handling and loading animation
        viewModel.items.subscribe(onNext: { (items) in
            if let items = items {
                self.items = items
                self.tableView.reloadData()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    
    // MARK: - UITableViewDelegate and UITableViewDataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = self.items else { return 0 }
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantTableViewCell.reusableIdentifier, for: indexPath) as! RestaurantTableViewCell
        
        if let item = self.items?[indexPath.row] {
            cell.photoImageView.sd_setImage(with: item.imageURL, completed: nil)
            cell.nameLabel.text = item.name
            cell.locationLabel.text = item.cityName
            cell.cuisineLabel.text = item.cuisine
            cell.ratingLabel.text = item.rating
            cell.reviewLabel.text = (item.numberOfReviews ?? "0") + " reviews"
            if let ratingString = item.rating, let ratingDouble = Double(ratingString) {
                let rating = Int(ratingDouble)
                cell.star1.image = rating < 1 ? #imageLiteral(resourceName: "StarOff") : #imageLiteral(resourceName: "StarOn")
                cell.star2.image = rating < 2 ? #imageLiteral(resourceName: "StarOff") : #imageLiteral(resourceName: "StarOn")
                cell.star3.image = rating < 3 ? #imageLiteral(resourceName: "StarOff") : #imageLiteral(resourceName: "StarOn")
                cell.star4.image = rating < 4 ? #imageLiteral(resourceName: "StarOff") : #imageLiteral(resourceName: "StarOn")
                cell.star5.image = rating < 5 ? #imageLiteral(resourceName: "StarOff") : #imageLiteral(resourceName: "StarOn")
            }
        }
        
        return cell
    }
}
