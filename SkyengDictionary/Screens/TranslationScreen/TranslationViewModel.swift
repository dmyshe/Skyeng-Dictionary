import Foundation
import UIKit

class TranslationViewModel {
    
    var meaning: [Meaning] = []
    var previousSelectedIndex: Int?
    var selectedIndex: Int?
    var imageURL: String?
    
    public func getTranslationAndTranscription( in indexPath: Int) -> (text: String, transcription: String) {
        let text = meaning[indexPath].translation.text
        let transcription = meaning[indexPath].transcription ?? ""
        return (text, transcription)
    }
    
    func getImageData(from url: String) -> Data? {
        guard let url = URL(string: "https:\(url)"), let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}
