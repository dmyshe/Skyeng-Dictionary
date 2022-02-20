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
            
            static let speakerIcon = UIImage(systemName: "speaker.2.fill")!.withTintColor(.black,renderingMode: .alwaysOriginal)
            
            static let starIcon2 = UIImage(systemName: "star.fill")!
            static let clockIcon = UIImage(systemName: "star.fill")!
            static let trashIcon = UIImage(systemName: "trash.fill")!

        }
        
        
        struct Layout {
            static let defaultPadding: CGFloat = 16
            static let defaultOffset : CGFloat = 8

            static let imageViewHeight: CGFloat = 100
            static let imageViewWidth: CGFloat = 100
            
            static let contentSpacing: CGFloat = 4
        }
    }
    
}
