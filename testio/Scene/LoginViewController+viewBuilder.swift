import UIKit

extension LoginViewController {
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
        textField.font = .textFieldFont
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.textFieldPlaceholderColor,
                NSAttributedString.Key.font: UIFont.textFieldFont
            ]
        )
        textField.isSecureTextEntry = isSecureTextEntry
        textField.layer.cornerRadius = 12.0
        
        textField.tintColor = .textFieldPlaceholderColor
        textField.setIcon(UIImage(systemName: iconName)!)
        
        return textField
    }
}
