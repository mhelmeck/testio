protocol SessionService {
    func isLoggedIn() -> Bool
}

class DefaultSessionService: SessionService {
    
    // MARK: - Properties
    
    private let storage: Storage
    
    // MARK: - Init
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    // MARK: - Api
    
    func isLoggedIn() -> Bool {
        guard let session = storage.readSession() else {
            return false
        }
        
        return !session.token.isEmpty
    }
}
