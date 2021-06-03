//
//  Observable+RxSection.swift
//  Demo
//
//  Created by Mac on 29.07.2020.
//  Copyright © 2020 HipLabs. All rights reserved.
//

import RxSwift
import RxRelay

public extension ObservableType where Element == [BaseCellModel] {
    func wrapToSection() -> Observable<[RxSectionModel]> {
        return map({ models -> [RxSectionModel] in
            let rxModels = models.map { RxCellModel(model: $0) }
            return [RxSectionModel(title: "", identity: "1", items: rxModels)]
        })
    }
}
