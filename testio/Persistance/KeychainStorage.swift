import Foundation
import Security

class KeychainStorage: SecureStorage {
    
    // MARK: - Properties
    
    private let service = "com.testio.keychain_storage"
    
    // MARK: - Api
    
    func write<T: Encodable>(_ item: T, forKey key: String) {
        guard let data = try? JSONEncoder().encode(item) else {
            return
        }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            let updateQuery: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: key
            ]
            let attributesToUpdate: [String: Any] = [
                kSecValueData as String: data
            ]
            SecItemUpdate(updateQuery as CFDictionary, attributesToUpdate as CFDictionary)
        } else if status != errSecSuccess {
            print("Error saving token to keychain: \(status)")
        } else {
            print("Token saved successfully.")
        }
    }
    
    func read<T: Decodable>(forKey key: String) -> T? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecSuccess, let data = item as? Data, let item = try? JSONDecoder().decode(T.self, from: data) {
            return item
        } else {
            print("Error reading token from keychain: \(status)")
            return nil
        }
    }
    
    func delete(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key
        ]

        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            print("Error removing token from keychain: \(status)")
        } else {
            print("Token removed successfully.")
        }
    }
}
