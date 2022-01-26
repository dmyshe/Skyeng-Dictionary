import Foundation

protocol ServiceManagerProtocol {
    func search(word: String, then handler: @escaping (Result<[Translate],TranslateError>) -> Void)
}
