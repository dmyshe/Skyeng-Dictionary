import UIKit

protocol SearchViewModelDelegate: AnyObject {
    func reloadData()
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    
    var service: ServiceManagerProtocol = ServiceManager()
    
    var searchWord: String = "" {
        didSet {
            if searchWord.isEmpty {
                translations = []
            } else {
                getTranslation()
            }
        }
    }
    
    var words: [String] = [] {
        didSet {
            DispatchQueue.main.async { [delegate] in
                delegate?.reloadData()
            }
        }
    }
    
    var translations: [Translate] = [] {
        didSet {
            words = translations.map { $0.text }.sorted()
        }
    }
    
    public func getWordsAndMeaning( in indexPath: Int) -> (text: String, meaning: String) {
        let text = words[indexPath]
        let meaning = translations[indexPath].meanings.first?.translation.text ?? ""
        return (text, meaning)
    }
    
    func getTranslation() {
        service.search(word: searchWord) { [unowned self] result in
            switch result {
            case .success(let translate):
                self.translations = translate
            case .failure:
                break
            }
        }
    }
}
