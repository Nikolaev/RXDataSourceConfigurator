//
//  CollectionViewExampleConfigurator.swift
//  Example
//
//  Created by Mac on 28.05.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class CollectionViewExampleConfigurator {
    
    typealias Module = (
        viewController: UIViewController,
        viewModel: CollectionViewExampleModuleProtocol
    )
    
    class func configure() -> Module {
        let viewController = createViewController()
        let dependencies = createDependencies()
        let viewModel = CollectionViewExampleViewModel(
            dependencies: dependencies,
            moduleInput: .init()
        )
        viewController.viewModel = viewModel
        return (viewController, viewModel)
    }
    
    private class func createViewController() -> CollectionViewExampleViewController {
        return CollectionViewExampleViewController()
    }
    
    private class func createDependencies() -> CollectionViewExampleViewModel.Dependencies {
        let dependencies = CollectionViewExampleViewModel.Dependencies()
        return dependencies
    }
    
}
