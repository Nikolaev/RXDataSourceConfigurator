//
//  CollectionViewExampleView.swift
//  Example
//
//  Created by Mac on 28.05.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SnapKit

class CollectionViewExampleView: UIView {
    
    lazy var cvItems = UICollectionView(frame: .zero, collectionViewLayout: itemsLayout)
    let itemsLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        configureView()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureView() {
        backgroundColor = .white
        cvItems.backgroundColor = .white
        cvItems.translatesAutoresizingMaskIntoConstraints = false
        
        itemsLayout.scrollDirection = .vertical
        itemsLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        itemsLayout.minimumLineSpacing = 10
        itemsLayout.minimumInteritemSpacing = 10
    }
    
    private func addSubviews() {
        addSubview(cvItems)
    }
    
    private func makeConstraints() {
        cvItems.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
