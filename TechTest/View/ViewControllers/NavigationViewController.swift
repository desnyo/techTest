//
//  NavigationViewController.swift
//  TechTest
//
//  Created by Miklos Lang on 2018. 06. 11..
//  Copyright © 2018. Miklos Lang. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor(red: 65.0 / 255.0, green: 133.0 / 255.0, blue: 222.0 / 255.0, alpha: 1.0)
        self.navigationBar.tintColor = .white
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let topViewController = self.topViewController else { return .default }
        return topViewController.preferredStatusBarStyle
    }
}
