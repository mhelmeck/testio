import Foundation

struct Credentials: Encodable {
    let username: String
    let password: String
    
    func isValid() -> Bool {
        username == "tesonet" && password == "partyanimal"
    }
}
