//
//  RXDataSourceConfigurator.swift
//  Demo
//
//  Created by User on 09.07.2020.
//  Copyright © 2020 Organization. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift
import RxRelay
import RxCocoa

public protocol CellActionHandler {
    var action: PublishRelay<CellAction> { get }
    func act(_ action: CellAction)
}

public protocol CellAction {}

open class RXDataSourceConfigurator {
    
    private let commonAction = PublishRelay<CellAction>()
    
    public init() {
        
    }
    
    public func handle<T: CellAction>(action: T.Type) -> Observable<T> {
        return commonAction.map { action -> T? in
            guard let action = action as? T else {
                return nil
            }
            return action
        }
        .filterNil()
    }
        
    public func tableDataSource() -> RxTableViewSectionedReloadDataSource<RxSectionModel> {
        return RxTableViewSectionedReloadDataSource<RxSectionModel> { [weak self] (ds, tv, ip, item) -> UITableViewCell in
            guard let sself = self,
                  let cellClass = item.model.cellClass(context: .tableView) as? UITableViewCell.Type else
            {
                fatalError("Expecting cellClass to be descendant of UITableViewCell")
            }
            let cell = tv.dequeueReusableCell(
                withClass: cellClass,
                for: ip,
                classSuffix: item.model.cellClassSuffix(context: .tableView)
            )
            if let configurableCell = cell as? RXDSConfigurableRaw {
                configurableCell.configure(rawData: item.model)
                configurableCell.configure(actionHandler: sself, ip: ip)
            }
            return cell
        }
    }
    
    public func animatableTableDataSource(animation: AnimationConfiguration = .fade) -> RxTableViewSectionedAnimatedDataSource<RxSectionModel> {
        return RxTableViewSectionedAnimatedDataSource<RxSectionModel>(
            animationConfiguration: animation,
            configureCell:
        { [weak self] (ds, tv, ip, item) -> UITableViewCell in
            guard let sself = self,
                  let cellClass = item.model.cellClass(context: .tableView) as? UITableViewCell.Type else
            {
                fatalError("Expecting cellClass to be descendant of UITableViewCell")
            }
            let cell = tv.dequeueReusableCell(
                withClass: cellClass,
                for: ip,
                classSuffix: item.model.cellClassSuffix(context: .tableView)
            )
            if let configurableCell = cell as? RXDSConfigurableRaw {
                configurableCell.configure(rawData: item.model)
                configurableCell.configure(actionHandler: sself, ip: ip)
            }
            return cell
        })
    }
    
    public func collectionDataSource() -> RxCollectionViewSectionedReloadDataSource<RxSectionModel> {
        RxCollectionViewSectionedReloadDataSource<RxSectionModel>
        { [weak self] (ds, cv, ip, item) -> UICollectionViewCell in
            guard let sself = self,
                  let cellClass = item.model.cellClass(context: .collectionView) as? UICollectionViewCell.Type else
            {
                fatalError("Expecting cellClass to be descendant of UICollectionViewCell")
            }
            let cell = cv.dequeueReusableCell(
                withClass: cellClass,
                for: ip,
                classSuffix: item.model.cellClassSuffix(context: .collectionView)
            )
            if let configurableCell = cell as? RXDSConfigurableRaw {
                configurableCell.configure(rawData: item.model)
                configurableCell.configure(actionHandler: sself, ip: ip)
            }
            return cell
        }
    }
        
    public func animatedСollectionDataSource(animation: AnimationConfiguration = .fade) -> RxCollectionViewSectionedAnimatedDataSource<RxSectionModel> {
        RxCollectionViewSectionedAnimatedDataSource<RxSectionModel>
        { [weak self] (ds, cv, ip, item) -> UICollectionViewCell in
            guard let sself = self,
                  let cellClass = item.model.cellClass(context: .collectionView) as? UICollectionViewCell.Type else
            {
                fatalError("Expecting cellClass to be descendant of UICollectionViewCell")
            }
            let cell = cv.dequeueReusableCell(
                withClass: cellClass,
                for: ip,
                classSuffix: item.model.cellClassSuffix(context: .collectionView)
            )
            if let configurableCell = cell as? RXDSConfigurableRaw {
                configurableCell.configure(rawData: item.model)
                configurableCell.configure(actionHandler: sself, ip: ip)
            }
            return cell
        }
    }
    
}

extension RXDataSourceConfigurator: CellActionHandler {
    
    public var action: PublishRelay<CellAction> {
        return commonAction
    }
    
    public func act(_ action: CellAction) {
        commonAction.accept(action)
    }
    
}

// MARK: - animation configuration
public extension AnimationConfiguration {
    
    static var automatic: AnimationConfiguration = {
        return AnimationConfiguration(insertAnimation: .automatic, reloadAnimation: .automatic, deleteAnimation: .automatic)
    }()
    
    static var fade: AnimationConfiguration = {
        return AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .fade)
    }()
    
    static var none: AnimationConfiguration = {
        return AnimationConfiguration(insertAnimation: .none, reloadAnimation: .none, deleteAnimation: .none)
    }()
    
}
