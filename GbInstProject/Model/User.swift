import Foundation

struct User {
    let identifier: Int
    let userName: String
    let avatarImageURLString: String
    let fullName: String
}

extension User {
    
    init(dictionary: [String: Any]) {
        self.init(
            identifier: Int(dictionary["id"] as! String)!,
            userName: dictionary["username"] as! String,
            avatarImageURLString: dictionary["profile_picture"] as! String,
            fullName: dictionary["full_name"] as! String)
    }
}
