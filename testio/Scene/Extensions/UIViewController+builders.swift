import UIKit

extension UIViewController {
    static func buildStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16.0
        
        return stackView
    }
    
    static func buildImageView(name: String, contentMode: UIView.ContentMode) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: name)!
        imageView.contentMode = contentMode
        
        return imageView
    }
    
    static func buildTextField(
        placeholder: String,
        iconName: String,
        isSecureTextEntry: Bool
    ) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .textFieldBackgroundColor
        textField.textColor = .textFieldTextColor
        textField.font = .defaultTextFont
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.textFieldPlaceholderColor,
                NSAttributedString.Key.font: UIFont.defaultTextFont
            ]
        )
        textField.isSecureTextEntry = isSecureTextEntry
        textField.layer.cornerRadius = 10.0
        textField.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        textField.tintColor = .textFieldPlaceholderColor
        textField.setIcon(UIImage(systemName: iconName)!)
        
        return textField
    }
    
    static func buildButton() -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = .defaultTextFont
        button.tintColor = .white
        button.backgroundColor = .loginButtonColor
        button.layer.cornerRadius = 10.0
        button.isEnabled = false
        
        return button
    }
    
    static func buildActivityIndicatorView() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        
        return indicator
    }
    
    static func buildLabel(text: String? = nil, font: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textColor = textColor
        label.font = font
        
        return label
    }
    
    static func buildListCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        return collectionView
    }
    
    private static func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.headerMode = .supplementary
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .clear
        
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
