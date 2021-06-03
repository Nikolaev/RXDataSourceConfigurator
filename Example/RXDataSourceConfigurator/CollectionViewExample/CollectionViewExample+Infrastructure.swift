//
//  CollectionViewExample+Infrastructure.swift
//  Example
//
//  Created by Mac on 28.05.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxRelay

protocol CollectionViewExampleModuleProtocol {
    var moduleInput: CollectionViewExampleViewModel.ModuleInput { get }
    var moduleOutput: CollectionViewExampleViewModel.ModuleOutput { get }
}

extension CollectionViewExampleViewModel {
    
    struct ModuleInput { }
    
    struct ModuleOutput { }

}
