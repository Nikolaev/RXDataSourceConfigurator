//
//  CounterCollectionCell.swift
//  Test1
//
//  Created by Mac on 31.05.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

public class CounterCollectionCell: UICollectionViewCell {

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

    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addSubviews()
        makeConstraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        addSubviews()
        makeConstraints()
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
        lblTitle.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        lblTitle.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        lblTitle.snp.makeConstraints { make -> Void in
            make.top.left.equalToSuperview()
            make.bottom.right.equalToSuperview().priority(999)
            make.width.equalTo(110)
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
