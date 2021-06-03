//
//  ViewController.swift
//  RXDataSourceConfigurator
//
//  Created by Vitaly Nikolaev on 06/03/2021.
//  Copyright (c) 2021 Vitaly Nikolaev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }
    
    @IBAction func presentTableViewExample(sender: Any) {
        let module = TableViewExampleConfigurator.configure()
        navigationController?.pushViewController(module.viewController, animated: true)
    }
    
    @IBAction func presentCollectionViewExample(sender: Any) {
        let module = CollectionViewExampleConfigurator.configure()
        navigationController?.pushViewController(module.viewController, animated: true)
    }

}

