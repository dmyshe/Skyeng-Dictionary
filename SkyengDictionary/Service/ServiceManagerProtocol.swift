import Foundation

protocol ServiceManagerProtocol {
    typealias Handler = Result<[Translate],TranslateError>
    func search(word: String, then handler: @escaping (Handler) -> Void)
}
