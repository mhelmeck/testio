import UIKit

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
    
    static var headerLabelColor: UIColor {
        Self.fromRGB(red: 102, green: 102, blue: 102, alpha: 1)
    }
    
    static var cellTextColor: UIColor {
        Self.fromRGB(red: 0, green: 0, blue: 0, alpha: 1)
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
