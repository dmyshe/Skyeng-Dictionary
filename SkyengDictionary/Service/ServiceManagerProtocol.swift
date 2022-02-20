import Foundation

protocol ServiceManagerProtocol {
    typealias TranslateHandler = Result<[Translate],TranslateError>
    func search(word: String, then completion: @escaping (TranslateHandler) -> Void)
}
