//
//  TableViewExample+Infrastructure.swift
//  Example
//
//  Created by Mac on 25.05.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import RxRelay

protocol TableViewExampleModuleProtocol {
    var moduleInput: TableViewExampleViewModel.ModuleInput { get }
    var moduleOutput: TableViewExampleViewModel.ModuleOutput { get }
}

extension TableViewExampleViewModel {
    
    struct ModuleInput { }
    
    struct ModuleOutput { }

}
