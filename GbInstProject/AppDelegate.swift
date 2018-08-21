import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        
        let firstViewController: UIViewController
        
        if Credential.isUserAuthenticated {
            let mainViewController = UIStoryboard(
                name: "Main",
                bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
            
            firstViewController = mainViewController
            
        } else {
            guard let authenticationController = UIStoryboard(
                name: "Main",
                bundle: nil).instantiateViewController(withIdentifier: "AuthenticationViewController") as? AuthenticationViewController else {
                return false
            }
            
            authenticationController.delegate = self
            firstViewController = authenticationController
        }
        
        self.window?.rootViewController = firstViewController
        self.window?.makeKeyAndVisible()
        return true
    }
}


extension AppDelegate: AuthenticationViewControllerDelegate {
    func authenticationViewController(_ viewController: UIViewController, authorizedWith token: String?) {
        
        Credential.token = token
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainViewController")
        viewController.present(mainViewController, animated: true, completion: nil)
    }
}

