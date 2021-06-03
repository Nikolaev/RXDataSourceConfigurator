//
//  RXDSContainerConfigurable.swift
//  Example
//
//  Created by Mac on 28.05.2021.
//

import Foundation
import RxSwift

public protocol RXDSContainerConfigurableRaw {
    func configure(rawData: Any)
    func configure(actionHandler: CellActionHandler, ip: IndexPath, reuseBag: DisposeBag)
    func contentInsets() -> UIEdgeInsets?
}

public protocol RXDSContainerConfigurable: RXDSContainerConfigurableRaw {
    associatedtype ViewModel: DiffIdentifiable
    func configure(with vm: ViewModel)
}

public extension RXDSContainerConfigurable {
    func configure(rawData: Any) {
        if let vm = rawData as? ViewModel {
            configure(with: vm)
        }
    }
}

public extension RXDSContainerConfigurableRaw {
    func contentInsets() -> UIEdgeInsets? { nil }
}
