import Foundation
import Security

class KeychainStorage: Storage {
    private let service = "com.testio.service"
    private let tokenKey = "session_token"

    init() {
        print("my_log init KeychainStorage")
    }
    deinit {
        print("my_log deinit KeychainStorage")
    }
    
    func writeToken(_ token: String) {
        guard let tokenData = token.data(using: .utf8) else { return }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: tokenKey,
            kSecValueData as String: tokenData
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            let updateQuery: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: tokenKey
            ]
            let attributesToUpdate: [String: Any] = [
                kSecValueData as String: tokenData
            ]
            SecItemUpdate(updateQuery as CFDictionary, attributesToUpdate as CFDictionary)
        } else if status != errSecSuccess {
            print("Error saving token to keychain: \(status)")
        } else {
            print("Token saved successfully.")
        }
    }

    func readToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: tokenKey,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecSuccess, let data = item as? Data, let token = String(data: data, encoding: .utf8) {
            return token
        } else {
            print("Error reading token from keychain: \(status)")
            return nil
        }
    }

    func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: tokenKey
        ]

        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            print("Error removing token from keychain: \(status)")
        } else {
            print("Token removed successfully.")
        }
    }
}

