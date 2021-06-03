//
//  CollectionViewExampleViewController.swift
//  Example
//
//  Created by Mac on 28.05.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RXDataSourceConfigurator

class CollectionViewExampleViewController: UIViewController {
    
    // MARK: - Infrastructure
    var viewModel: CollectionViewExampleViewModelProtocol!
    private let bag = DisposeBag()
    private lazy var customView: CollectionViewExampleView = {
        let customView = CollectionViewExampleView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        return customView
    }()
    
    let dsConfigurator = RXDataSourceConfigurator()

    // MARK: - View lifecycle
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configure(bindings: viewModel.bindings)
        configure(commands: viewModel.commands)
    }

    deinit {
        print("💀" + "\(type(of: self)) " + "dead")
    }
    
    // MARK: - Private
    
    private func configureUI() {
        title = "CollectionView Configurator Example"
    }
    
    private func configure(bindings: CollectionViewExampleViewModel.Bindings) {
        let dataSource = dsConfigurator.animatedСollectionDataSource()
        bindings.cellModels
            .filterNil()
            .map({ $0 as [BaseCellModel] })
            .wrapToSection()
            .bind(to: customView.cvItems.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    private func configure(commands: CollectionViewExampleViewModel.Commands) {
        dsConfigurator.handle(action: ItemView.Action.self)
            .subscribe(onNext: { [weak self] action in
                switch action {
                case let .select(id):
                    self?.viewModel.commands.select.accept(id)
                case let .delete(id):
                    self?.viewModel.commands.delete.accept(id)
                }
            })
            .disposed(by: bag)
        
        dsConfigurator.handle(action: CounterCollectionCell.TapAction.self)
            .map{ $0.id }
            .bind(to: commands.increaseCounter)
            .disposed(by: bag)
    }
    
}
