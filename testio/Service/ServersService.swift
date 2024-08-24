protocol ServersService {
    func getServers() async throws -> [Server]
}
