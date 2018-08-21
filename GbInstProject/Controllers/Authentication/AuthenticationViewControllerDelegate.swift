import Foundation
import UIKit

protocol AuthenticationViewControllerDelegate: class {
    
    func authenticationViewController(
        _ viewController: UIViewController,
        authorizedWith token: String?)
}
