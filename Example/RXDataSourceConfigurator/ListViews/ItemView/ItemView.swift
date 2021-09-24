//
//  ItemView.swift
//  Example
//
//  Created by Mac on 25.05.2021.
//

import UIKit
import RxSwift
import RxCocoa

class ItemView: UIView {
    
    struct Model {
        let id: String
        let title: String
        let subTitle: String
        let selected: Bool
    }
     
    struct Output {
        let select = PublishRelay<Void>()
        let delete = PublishRelay<Void>()
    }
    
    struct UIConstants {
        static let normalBgColor = UIColor(white: 0.9, alpha: 1)
        static let selectedBgColor = UIColor(white: 0.8, alpha: 1)
    }
    
    var model: Model? {
        didSet {
            updateUI()
        }
    }
        
    let output = Output()
        
    private let bag = DisposeBag()
    private let lblTitle = UILabel()
    private let lblSubTitle = UILabel()
    private let btnSelect = UIButton(type: .system)
    private let btnDelete = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
}

private extension ItemView {
    
    func configure() {
        configureView()
        addSubviews()
        setupConstraints()
        configureRx()
    }
    
    func configureView() {
        backgroundColor = UIConstants.normalBgColor
        lblTitle.textColor = .darkGray
        lblTitle.font = UIFont.systemFont(ofSize: 20)
        lblSubTitle.textColor = .gray
        
        btnDelete.setTitle("Delete", for: .normal)
    }
    
    func addSubviews() {
        [lblTitle, lblSubTitle, btnSelect, btnDelete].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }    }
    
    func setupConstraints() {
        lblTitle.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(20)
            make.right.equalTo(btnDelete.snp.left).offset(-5)
        }
        lblSubTitle.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview().inset(20)
            make.top.equalTo(lblTitle.snp.bottom).offset(10)
            make.right.equalTo(btnDelete.snp.left).offset(-5)
        }
        btnSelect.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        btnDelete.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview().inset(10)
            make.width.equalTo(50)
        }
        btnDelete.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    func configureRx() {
        btnSelect.rx.tap.bind(to: output.select).disposed(by: bag)
        btnDelete.rx.tap.bind(to: output.delete).disposed(by: bag)
    }
    
    func updateUI() {
        guard let model = model else {
            return
        }
        lblTitle.text = model.title
        lblSubTitle.text = model.subTitle
        backgroundColor = model.selected ? UIConstants.selectedBgColor : UIConstants.normalBgColor
    }
    
}
