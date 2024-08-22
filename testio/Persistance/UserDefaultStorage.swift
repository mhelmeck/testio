import Foundation

class UserDefaultStorage: Storage {
    // MARK: - Properties
    
    private let tokenKey = "user_default_storage_token"
    
    // MARK: - Init
    
    init() {
        print("my_log init UserDefaultStorage")
    }
    deinit {
        print("my_log deinit UserDefaultStorage")
    }
    
    // MARK: - Api
    
    func writeToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    func readToken() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }
    
    func deleteToken() {
        UserDefaults.standard.set(nil, forKey: tokenKey)
    }
}
