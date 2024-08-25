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
        textField.font = .loginTextFont
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.textFieldPlaceholderColor,
                NSAttributedString.Key.font: UIFont.loginTextFont
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
        button.titleLabel?.font = .loginTextFont
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
}
