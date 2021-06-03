//
//  ContainerCellModel.swift
//  Example
//
//  Created by Mac on 26.05.2021.
//

import Foundation
import UIKit

public struct ContainerCellModel<ContentView: UIView & RXDSContainerConfigurable> {
    
    public let id: String
    public let model: ContentView.ViewModel
    
    public init(id: String, model: ContentView.ViewModel) {
        self.id = id
        self.model = model
    }
    
}

extension ContainerCellModel: DiffIdentifiable {}

extension ContainerCellModel: BaseCellModel {
    
    public var identity: String {
        "ContainerCellModel:" + id
    }
    
    public var diffIdentifier: String {
        model.diffIdentifier
    }
    
    public func cellClass(context: BaseCellModelContext) -> AnyClass {
        let cellClass: AnyClass
        switch context {
        case .tableView:
            cellClass = ContainerTableViewCell<ContentView>.self
        case .collectionView:
            cellClass = ContainerCollectionViewCell<ContentView>.self
        }
        return cellClass
    }
    
    public func cellClassSuffix(context: BaseCellModelContext) -> String? {
        String(describing: ContentView.self)
    }
    
}
