import UIKit

class MainViewController: UIViewController {
    
    struct API {
        static let host = "https://api.instagram.com/v1"
        static let token = "?access_token="
        
        static func URLFor(
            apiMethod: String,
            token: String)-> String {
            
            return self.host + apiMethod + self.token + token
        }
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelLoading()
        getUser()
    }
    
    func getUser() {
        guard let token = Credential.token else {
            return
        }
        
        APIManager.shared.load(API.URLFor(
            apiMethod: "/users/self", token: token), { [weak self] (result) in
                
            guard let result = (result as? [String: Any])?["data"] as? [String: Any] else {
                DispatchQueue.main.async {
                    
                    let valueToSet = "Error"
                    self?.setLabel(text: valueToSet)
                }
                return
            }
            
            let user = User(dictionary: result)
            self?.setLabel(text: user.userName)
        })
    }
    
    func setLabel(text: String) {
        DispatchQueue.main.async {
            self.userNameLabel.text = text
        }
    }
    
    func setLabelLoading() {
        let valueOfLoadingText = "loading..."
        self.setLabel(text: valueOfLoadingText)
    }
    
}

