//
//  SimpleCellModel.swift
//  Example
//
//  Created by Mac on 27.05.2021.
//

import Foundation
import UIKit
import RXDataSourceConfigurator

public struct CounterCellModel  {
    
    let model: CounterModel
        
}

extension CounterCellModel: BaseCellModel {
    
    public var identity: String {
        "SimpleCellModel: " + model.id
    }
    
    public var diffIdentifier: String {
        "\(model.count)"
    }
    
    public func cellClass(context: BaseCellModelContext) -> AnyClass {
        let cellClass: AnyClass
        switch context {
        case .tableView:
            cellClass = CounterCell.self
        case .collectionView:
            cellClass = CounterCollectionCell.self
        }
        return cellClass
    }
    
    public func cellClassSuffix(context: BaseCellModelContext) -> String? {
        nil
    }
    
}
