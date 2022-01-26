import Foundation
import UIKit

struct Constants {
    struct UI {
        struct Images {
            static let cameraIcon: UIImage = {
                let configuration = UIImage.SymbolConfiguration(pointSize: 24)
                let image = UIImage(systemName: "camera.fill",
                                    withConfiguration: configuration)!.withTintColor(.black,renderingMode: .alwaysOriginal)
                return image
            }()
            
            static let starIcon: UIImage = {
                let configuration = UIImage.SymbolConfiguration(pointSize: 10)
                let image = UIImage(systemName: "star.fill",
                                    withConfiguration: configuration)!.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
                return image
            }()
        }
        
        struct Layout {
            static let defaultPadding: CGFloat = 16
        }
    }
    
}
