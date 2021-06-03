//
//  TestViewModel.swift
//  Example
//
//  Created by Mac on 25.05.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import RxCocoa
import RXDataSourceConfigurator

protocol TableViewExampleViewModelProtocol {
    var bindings: TableViewExampleViewModel.Bindings { get }
    var commands: TableViewExampleViewModel.Commands { get }
}

extension TableViewExampleViewModel {
    
    struct Dependencies { }
    
    struct Bindings {
        let networkActivity = BehaviorRelay<Bool>(value: false)
        let error = BehaviorRelay<Error?>(value: nil)
        let cellModels = BehaviorRelay<[BaseCellModel]?>(value: nil)
    }
    
    struct Commands {
        let select = PublishRelay<ItemModel.Id>()
        let delete = PublishRelay<ItemModel.Id>()
        let increaseCounter = PublishRelay<CounterModel.Id>()
    }
    
}

class TableViewExampleViewModel: TableViewExampleModuleProtocol, TableViewExampleViewModelProtocol {
    
    let moduleInput: ModuleInput
    let moduleOutput = ModuleOutput()
    
    let bindings = Bindings()
    let commands = Commands()
    
    private let dp: Dependencies
    private let bag = DisposeBag()
    
    private let counters = BehaviorRelay<[CounterModel]?>(value: nil)
    private let items = BehaviorRelay<[ItemModel]?>(value: nil)
    private let selectedItem = BehaviorRelay<ItemModel?>(value: nil)
    
    private let counterCells = PublishRelay<[BaseCellModel]>()
    private let itemsCells = PublishRelay<[BaseCellModel]>()
    
    init(dependencies: Dependencies, moduleInput: ModuleInput) {
        self.dp = dependencies
        self.moduleInput = moduleInput
        configure(moduleInput: moduleInput)
        configure(commands: commands)
        configure()
    }

    deinit {
        print("💀" + "\(type(of: self)) " + "dead")
    }

}

private extension TableViewExampleViewModel {
    
    func configure(moduleInput: ModuleInput) {
        
    }
    
    func configure(commands: Commands) {
        commands.select.bind(to: select()).disposed(by: bag)
        commands.delete.bind(to: delete()).disposed(by: bag)
        commands.increaseCounter.bind(to: increaseCounter()).disposed(by: bag)
    }
    
    func configure() {
        items.filterNil().bind(to: parseItems()).disposed(by: bag)
        counters.filterNil().bind(to: parseCounts()).disposed(by: bag)
        
        Observable.combineLatest(counterCells, itemsCells)
            .map { $0 + $1 }
            .bind(to: bindings.cellModels)
            .disposed(by: bag)
        
        fetchCounters()
        fetchItems()
    }
    
}

// MARK: - Items
private extension TableViewExampleViewModel {
    
    func fetchItems() {
        let models = (0...10).map { index -> ItemModel in
            .init(id: "\(index)",
                  title: "Title \(index)",
                  subTitle: "Subtitle \(index)")
        }
        self.items.accept(models)
    }
    
    func parseItems() -> Binder<[ItemModel]> {
        return .init(self) { target, items in
            let selectedId = target.selectedItem.value?.id
            let cellModels = items.enumerated().map { index, item -> BaseCellModel in
                let itemVM = ItemView.Model(id: item.id,
                                            title: item.title,
                                            subTitle: item.subTitle,
                                            selected: item.id == selectedId)
                let cellVM = ContainerCellModel<ItemView>(id: item.id, model: itemVM)
                return cellVM
            }
            target.itemsCells.accept(cellModels)
        }
    }
    
    func select() -> Binder<ItemModel.Id> {
        return .init(self) { (target, id) in
            guard let items = target.items.value,
                  let item = items.first(where: { $0.id == id })
            else {
                return
            }
            target.selectedItem.accept(item)
            target.items.accept(target.items.value)
        }
    }
    
    func delete() -> Binder<ItemModel.Id> {
        return .init(self) { (target, id) in
            guard var items = target.items.value,
                  let index = items.firstIndex(where: { $0.id == id })
            else {
                return
            }
            items.remove(at: index)
            target.items.accept(items)
        }
    }
    
}

// MARK: - Counters
private extension TableViewExampleViewModel {
    
    func fetchCounters() {
        let counters = (0...2).map { index -> CounterModel in
            .init(id: "\(index)", count: 0)
        }
        self.counters.accept(counters)
    }
    
    func parseCounts() -> Binder<[CounterModel]> {
        return .init(self) { (target, titles) in
            let cellModels = titles.map { CounterCellModel(model: $0) }
            target.counterCells.accept(cellModels)
        }
    }
    
    
    func increaseCounter() -> Binder<CounterModel.Id> {
        return .init(self) { (target, id) in
            guard var counters = target.counters.value,
                  let index = counters.firstIndex(where: { $0.id == id })
            else {
                return
            }
            let current = counters[index]
            let udated = CounterModel(id: current.id, count: current.count + 1)
            counters[index] = udated
            target.counters.accept(counters)
        }
    }
    
}
