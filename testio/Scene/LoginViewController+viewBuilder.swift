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
        let textFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = backgroundColor
        textField.textColor = textColor
        textField.font = textFont
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor, NSAttributedString.Key.font: textFont]
        )
        textField.isSecureTextEntry = isSecureTextEntry
        textField.layer.cornerRadius = 12.0
        
        textField.tintColor = placeholderColor
        textField.setIcon(UIImage(systemName: iconName)!)
        
        return textField
    }
}

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 8, y: 12, width: 16, height: 16))
        iconView.image = image
        
        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        iconContainerView.addSubview(iconView)
        
        leftView = iconContainerView
        leftViewMode = .always
    }
}

private let usernameTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .clear
    textField.placeholder = "Username"
    textField.borderStyle = .roundedRect
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.leftView = UIImageView(image: UIImage(systemName: "person.circle"))
    textField.leftViewMode = .always
    
    return textField
}()

private let passwordTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Password"
    textField.borderStyle = .roundedRect
    
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.leftView = UIImageView(image: UIImage(systemName: "lock.circle"))
    textField.leftViewMode = .always
    
    return textField
}()

extension UIColor {
    static func fromRGB(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
}

let placeholderColor = UIColor.fromRGB(red: 60, green: 60, blue: 67, alpha: 0.7)
let backgroundColor = UIColor.fromRGB(red: 118, green: 118, blue: 128, alpha: 0.12)
let textColor = UIColor.fromRGB(red: 60, green: 60, blue: 67, alpha: 1)
