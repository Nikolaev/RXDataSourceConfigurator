//
//  CounterCell.swift
//  Example
//
//  Created by Mac on 27.05.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

public class CounterCell: UITableViewCell {
    
    public private(set) var disposeBag = DisposeBag()
    
    private let lblTitle = UILabel()
    private let btnAction = UIButton()
        
    var model: CounterModel? {
        didSet {
            updateUI()
        }
    }
    
    var tap: ControlEvent<Void> {
        return btnAction.rx.tap
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    private func configure() {
        lblTitle.textAlignment = .center
        lblTitle.numberOfLines = 0
    }
    
    private func addSubviews() {
        contentView.addSubview(lblTitle)
        contentView.addSubview(btnAction)
    }
    
    private func makeConstraints() {
        lblTitle.snp.makeConstraints { make -> Void in
            make.edges.equalToSuperview().inset(15)
        }
        btnAction.snp.makeConstraints { make -> Void in
            make.edges.equalToSuperview()
        }
    }
    
    private func updateUI() {
        guard let model = model else {
            return
        }
        lblTitle.text = "Count: \(model.count)"
    }
    
}
