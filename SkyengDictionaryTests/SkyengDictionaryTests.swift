import XCTest
@testable import SkyengDictionary

class ServiceManagerMock: ServiceManagerProtocol {
    var isCalled = false
    func search(word: String, then handler: @escaping (Handler) -> Void) {
        isCalled = true
    }
}

class SkyengUnitTests: XCTestCase {

    // Name: Translation Word Test
    // Input: word "test"
    // Output: list of values
    func testSearchPositive() throws {
        let manager: ServiceManagerProtocol = ServiceManager()
        manager.search(word: "test") { result in
            switch result {
            case .success:
                print("Success")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    // Name: Empty string for translation
    // Input: word ""
    // Output: list of values for the empty string
    func testModelEmptyString() throws {
        let model = SearchViewModel()
        model.searchWord = "test"
        model.searchWord = ""
        XCTAssert(model.translations.isEmpty, "Translations is not empty")
    }
    
    func testSearchWordWithMock() {
        let mock: ServiceManagerProtocol = ServiceManagerMock()
        let model = SearchViewModel()
        model.service = mock
        model.searchWord = "test"
        
        let isCalled = (mock as? ServiceManagerMock)?.isCalled ?? false
        XCTAssert(isCalled, "not called")
    }
}
