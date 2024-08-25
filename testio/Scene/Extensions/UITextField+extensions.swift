import UIKit

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
