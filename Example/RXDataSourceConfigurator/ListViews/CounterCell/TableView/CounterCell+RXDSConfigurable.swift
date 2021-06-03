//
//  CounterCell+RXDSConfigurable.swift
//  Example
//
//  Created by Mac on 27.05.2021.
//

import Foundation
import RXDataSourceConfigurator

extension CounterCell: RXDSConfigurable {
    
    struct TapAction: CellAction {
        let id: String
    }
    
    public typealias ViewModel = CounterCellModel
    
    public func configure(with vm: ViewModel) {
        self.model = vm.model
    }
    
    public func configure(actionHandler: CellActionHandler, ip: IndexPath) {
        guard let model = model else {
            return
        }
        tap.map{ _ in TapAction(id: model.id) }
            .bind(to: actionHandler.action)
            .disposed(by: disposeBag)
    }
    
}
