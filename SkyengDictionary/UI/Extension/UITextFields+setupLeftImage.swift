import UIKit

extension UITextField {
    
    struct Spec {
        static let defaultImageName: String = "magnifyingglass"
    }
    
    func setupLeftImage(imageName: String) {
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
        let imageIcon = UIImage(systemName: imageName)?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.image = imageIcon
        
        let imageContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageContainerView.addSubview(imageView)

        self.leftView = imageContainerView
        self.leftViewMode = .always
    }
    
    func setupLeftImage() {
        setupLeftImage(imageName: Spec.defaultImageName)
    }
}
