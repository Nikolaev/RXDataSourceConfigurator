//
//  ContainerCollectionReusableView.swift
//  FlipCoffee
//
//  Created by Avvakumov Dmitry on 16.07.2020.
//  Copyright © 2020 Flip Coffee. All rights reserved.
//

import UIKit
import RxSwift

public class ContainerCollectionReusableView<ContentView: UIView & RXDSContainerConfigurable>: UICollectionReusableView {
    
    public private(set) lazy var cargoView: ContentView = {
        let view = ContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public private(set) var disposeBag = DisposeBag()
    private var cargoInsets: UIEdgeInsets?
    private var cargoConstraints: [NSLayoutConstraint] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints(insets: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    private func addSubviews() {
        addSubview(cargoView)
    }
    
    private func makeConstraints(insets: UIEdgeInsets) {
        cargoInsets = insets
        NSLayoutConstraint.deactivate(cargoConstraints)
        cargoConstraints = [
            cargoView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: insets.left),
            cargoView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -insets.right),
            cargoView.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top),
            cargoView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom),
        ]
        cargoConstraints.forEach { $0.priority = .init(999) }
        NSLayoutConstraint.activate(cargoConstraints)
    }
        
}

extension ContainerCollectionReusableView: RXDSConfigurable {
    
    public typealias ViewModel = ContainerCellModel<ContentView>
    
    public func configure(with vm: ViewModel) {
        cargoView.configure(rawData: vm.model)
    }
    
    public func configure(actionHandler: CellActionHandler, ip: IndexPath) {
        if let insets = cargoView.contentInsets(), insets != cargoInsets {
            makeConstraints(insets: insets)
        }
        cargoView.configure(actionHandler: actionHandler, ip: ip, reuseBag: disposeBag)
    }
    
}
