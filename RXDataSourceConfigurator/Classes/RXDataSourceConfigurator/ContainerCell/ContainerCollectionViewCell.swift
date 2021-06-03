//
//  ContainerCollectionViewCell.swift
//  FlipCoffee
//
//  Created by Avvakumov Dmitry on 14.07.2020.
//  Copyright © 2020 Flip Coffee. All rights reserved.
//

import UIKit
import RxSwift

public class ContainerCollectionViewCell<ContentView: UIView & RXDSContainerConfigurable>: UICollectionViewCell {
    
    public private(set) lazy var cargoView: ContentView = {
        let view = ContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public private(set) var disposeBag = DisposeBag()
        
    private var cargoInsets: UIEdgeInsets?
    
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
        contentView.addSubview(cargoView)
    }
    
    private func makeConstraints(insets: UIEdgeInsets) {
        cargoInsets = insets
        contentView.removeConstraints(cargoView.constraints)
        let cnstrs = [
            cargoView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: insets.left),
            cargoView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -insets.right),
            cargoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: insets.top),
            cargoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -insets.bottom),
        ]
        for c in cnstrs { c.priority = .init(999) }
        NSLayoutConstraint.activate(cnstrs)
    }
    
}

extension ContainerCollectionViewCell: RXDSConfigurable {

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
