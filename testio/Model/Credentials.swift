import Foundation

struct Credentials: Encodable {
    let username: String = "tesonet"
    let password: String = "partyanimal"
    
    func isValid() -> Bool {
        username == "tesonet" && password == "partyanimal"
    }
}
