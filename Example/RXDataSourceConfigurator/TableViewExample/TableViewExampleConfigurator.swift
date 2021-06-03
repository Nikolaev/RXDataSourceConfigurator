//
//  TableViewExampleConfigurator.swift
//  Example
//
//  Created by Mac on 25.05.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class TableViewExampleConfigurator {
    
    typealias Module = (
        viewController: UIViewController,
        viewModel: TableViewExampleModuleProtocol
    )
    
    class func configure() -> Module {
        let viewController = createViewController()
        let dependencies = createDependencies()
        let viewModel = TableViewExampleViewModel(
            dependencies: dependencies,
            moduleInput: .init()
        )
        viewController.viewModel = viewModel
        return (viewController, viewModel)
    }
    
    private class func createViewController() -> TableViewExampleViewController {
        return TableViewExampleViewController()
    }
    
    private class func createDependencies() -> TableViewExampleViewModel.Dependencies {
        let dependencies = TableViewExampleViewModel.Dependencies()
        return dependencies
    }
    
}
