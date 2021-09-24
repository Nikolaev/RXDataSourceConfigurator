//
//  ItemView+ContainerCellContentProtocol.swift
//  Example
//
//  Created by Mac on 26.05.2021.
//

import UIKit
import RxSwift
import RXDataSourceConfigurator

extension ItemView: RXDSContainerConfigurable {
    
    enum Action: CellAction {
        case select(id: ItemModel.Id)
        case delete(id: ItemModel.Id)
    }
    
    func configure(with vm: ItemView.Model) {
        model = vm
    }
    
    func configure(actionHandler: CellActionHandler, ip: IndexPath, reuseBag: DisposeBag) {
        guard let model = model else {
            return
        }
        output.select.map{ Action.select(id: model.id) }.bind(to: actionHandler.action).disposed(by: reuseBag)
        output.delete.map{ Action.delete(id: model.id) }.bind(to: actionHandler.action).disposed(by: reuseBag)
    }
        
    func contentInsets() -> UIEdgeInsets? {
        .init(top: 5, left: 10, bottom: 5, right: 10)
    }
}

extension ItemView.Model: DiffIdentifiable {
    
    var diffIdentifier: String {
        "\(title)|\(subTitle)|\(selected)"
    }
       
}
