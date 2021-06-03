//
//  RxCellModel.swift
//  Demo
//
//  Created by User on 09.07.2020.
//  Copyright © 2020 Organization. All rights reserved.
//

import RxDataSources

public struct RxCellModel: Equatable, IdentifiableType {
    
    public typealias Identity = String
    
    public var identity: String {
        return model.identity
    }
    
    public let model: BaseCellModel
    
    public init(model: BaseCellModel) {
        self.model = model
    }
    
    public static func == (lhs: RxCellModel, rhs: RxCellModel) -> Bool {
        if lhs.model.identity == rhs.model.identity {
            return lhs.model.diffIdentifier == rhs.model.diffIdentifier
        } else {
            return false
        }
    }
}
