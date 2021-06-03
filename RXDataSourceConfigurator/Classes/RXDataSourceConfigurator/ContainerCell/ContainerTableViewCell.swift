import UIKit
import RxSwift

public class ContainerTableViewCell<ContentView: UIView & RXDSContainerConfigurable>: UITableViewCell {
    
    public private(set) lazy var cargoView: ContentView = {
        let view = ContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var cargoInsets: UIEdgeInsets?
    
    public private(set) var disposeBag = DisposeBag()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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

extension ContainerTableViewCell: RXDSConfigurable {
    
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
