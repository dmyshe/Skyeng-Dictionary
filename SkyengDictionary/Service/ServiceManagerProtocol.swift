import Foundation

protocol ServiceManagerProtocol {
    typealias TranslateHandler = (Result<[Translate],TranslateError>) -> Void
    func search(word: String, then completion: @escaping TranslateHandler )
}
