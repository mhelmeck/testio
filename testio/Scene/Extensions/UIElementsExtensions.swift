import UIKit

// MARK: - UIColor

extension UIColor {
    static var textFieldPlaceholderColor: UIColor {
        Self.fromRGB(red: 60, green: 60, blue: 67, alpha: 0.7)
    }
    
    static var textFieldBackgroundColor: UIColor {
        Self.fromRGB(red: 118, green: 118, blue: 128, alpha: 0.12)
    }
    
    static var textFieldTextColor: UIColor {
        Self.fromRGB(red: 60, green: 60, blue: 67, alpha: 1)
    }
    
    static var loginButtonColor: UIColor {
        Self.fromRGB(red: 70, green: 135, blue: 255, alpha: 1)
    }
    
    private static func fromRGB(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: alpha
        )
    }
}

// MARK: - UIFont

extension UIFont {
    static var loginTextFont: UIFont {
        .systemFont(ofSize: 17, weight: .regular)
    }
}

// MARK: - UITextField

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
