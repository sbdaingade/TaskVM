
import Foundation

public enum AuthenticationError: Error, LocalizedError {
    case invalidCredentials
    case customError(String)
    var id: String {
        self.localizedDescription
    }
    
    
}
