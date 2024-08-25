import UIKit

class HomeHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    
    static var elementKind: String { UICollectionView.elementKindSectionHeader }
    
    private let serverLabel = UIViewController.buildLabel(text: "SERVER")
    private let distanceLabel = UIViewController.buildLabel(text: "DISTANCE", textAlignment: .right)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        installConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methos
    
    private func setupView() {
        backgroundColor = .textFieldBackgroundColor
        
        addSubview(serverLabel)
        addSubview(distanceLabel)
    }
    
    private func installConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48.0),
            
            serverLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            serverLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0),
            
            distanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            distanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0)
        ])
    }
}
