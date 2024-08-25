import Foundation

struct Server: Codable, Identifiable, Equatable {
    let id: String
    let distance: Int
    let name: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        distance = try container.decode(Int.self, forKey: .distance)
        name = try container.decode(String.self, forKey: .name)
        id = UUID().uuidString
    }
    
    enum CodingKeys: String, CodingKey {
        case distance
        case name
    }
}

extension Array where Element == Server {
    func indexOfServer(withId id: Server.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else {
            fatalError()
        }
        
        return index
    }
}
