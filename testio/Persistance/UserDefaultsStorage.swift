import Foundation

class UserDefaultsStorage: LocalStorage {
    
    // MARK: - Properties
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Init
    
    init() {
        print("my_log init UserDefaultsStorage")
    }
    deinit {
        print("my_log deinit UserDefaultsStorage")
    }
    
    // MARK: - Api
    
    func write<T: Encodable>(_ item: T, forKey key: String) {
        guard let data = try? JSONEncoder().encode(item) else {
            return
        }
        
        userDefaults.setValue(data, forKey: key)
    }
    
    func read<T: Decodable>(forKey key: String) -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            return nil
        }
        
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func delete(forKey key: String) {
        userDefaults.setValue(nil, forKey: key)
    }
}
