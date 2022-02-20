import Foundation

enum TranslateError: Error {
    case urlError
    case networkFailure(Error)
    case invalidData
}

class ServiceManager: ServiceManagerProtocol {
    
    let baseUrl = "https://dictionary.skyeng.ru/api/public/v1/"
    let searchMethod = "words/search"
    
    var session = URLSession.shared
    
    func search(word: String, then handler: @escaping (Handler) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)\(searchMethod)?search=\(word)") else {
            handler(.failure(.urlError))
            return
        }
        
        let task = session.dataTask(with: url) { result in
            switch result {
            case .success(let data):
                do {
                    let translate = try JSONDecoder().decode([Translate].self, from: data)
                    handler(.success(translate))
                } catch {
                    handler(.failure(.invalidData))
                }
            case .failure(let error):
                handler(.failure(.networkFailure(error)))
            }
        }
        task.resume()
    }
}

