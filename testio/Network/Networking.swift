protocol Networking {
    func getSession(credentials: Credentials) async throws -> UserSession
    func getServerList(token: String) async throws -> [Server]
}
