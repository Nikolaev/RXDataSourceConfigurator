//
//  RXDSConfigurable.swift
//  Example
//
//  Created by Mac on 26.05.2021.
//

import Foundation
import RxSwift

public protocol RXDSConfigurable: RXDSConfigurableRaw {
    associatedtype ViewModel: DiffIdentifiable
    func configure(with vm: ViewModel)
}

public protocol RXDSConfigurableRaw {
    func configure(rawData: Any)
    func configure(actionHandler: CellActionHandler, ip: IndexPath)
}

public protocol DiffIdentifiable {
    var diffIdentifier: String { get }
}

public extension RXDSConfigurableRaw {
    func configure(actionHandler: CellActionHandler, ip: IndexPath) {}
}

public extension RXDSConfigurable {
    func configure(rawData: Any) {
        if let vm = rawData as? ViewModel {
            configure(with: vm)
        }
    }
}
