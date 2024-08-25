import UIKit

class HomeCellContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var server: String = String()
        var distance: Int = 0
        
        func makeContentView() -> UIView & UIContentView {
            return HomeCellContentView(self)
        }
        
        func updated(for state: any UIConfigurationState) -> HomeCellContentView.Configuration {
            return self
        }
    }
    
    // MARK: - Properties
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    private let serverLabel = UIViewController.buildLabel(font: .defaultTextFont, textColor: .cellTextColor)
    private let distanceLabel = UIViewController.buildLabel(font: .defaultTextFont, textColor: .cellTextColor)
    
    // MARK: - Init
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        
        setupView()
        installConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        
        serverLabel.text = configuration.server
        distanceLabel.text = "\(configuration.distance) km"
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(serverLabel)
        addSubview(distanceLabel)
    }
    
    private func installConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 44.0),
            
            serverLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            serverLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0),
            
            distanceLabel.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -100.0),
            distanceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0)
        ])
    }
}

extension UICollectionViewListCell {
    func homeCellConfiguration() -> HomeCellContentView.Configuration {
        HomeCellContentView.Configuration()
    }
}
