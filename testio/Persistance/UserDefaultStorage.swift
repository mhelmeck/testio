import Foundation

class UserDefaultStorage: Storage {
    
    // MARK: - Properties
    
    private let tokenKey = "user_default_storage_token"
    
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
