import Foundation

class Credential {
    static let userDefaultsTokenKey = "userDefaultsTokenKey"
    
    
    static var isUserAuthenticated: Bool {
        return token != nil
    }
    
    static var token: String? {
        get {
            return UserDefaults.standard.value(forKey: userDefaultsTokenKey) as? String
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: userDefaultsTokenKey )
        }
    }
}
