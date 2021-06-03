//
//  BaseCellModel.swift
//  Demo
//
//  Created by Avvakumov Dmitry on 14.07.2020.
//  Copyright © 2020 HipLabs. All rights reserved.
//

import Foundation
import UIKit

public protocol BaseCellModel: DiffIdentifiable {
    var identity: String { get }
    var diffIdentifier: String { get }
    func cellClass(context: BaseCellModelContext) -> AnyClass
    func cellClassSuffix(context: BaseCellModelContext) -> String?
}

public enum BaseCellModelContext {
    case tableView
    case collectionView
}
