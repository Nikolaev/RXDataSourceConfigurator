//
//  RxSectionModel.swift
//  Demo
//
//  Created by User on 09.07.2020.
//  Copyright © 2020 Organization. All rights reserved.
//

import Foundation
import RxDataSources

public struct RxSectionModel: AnimatableSectionModelType {
    public typealias Item = RxCellModel
    public typealias Identity = String
    public var items: [Item]
    public let title: String
    public let identity: String
    
    public init(original: RxSectionModel, items: [Item]) {
        self.title = original.title
        self.identity = original.identity
        self.items = items
    }
    
    public init(title: String, identity: String, items: [Item]) {
        self.title = title
        self.identity = identity
        self.items = items
    }
}
