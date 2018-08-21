import UIKit
import WebKit

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    weak var delegate: AuthenticationViewControllerDelegate?
    
    let clientId = "32c4205becb24a75a5ebba591078aa92"
    let redirectURI = "https://instagram.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let URLValue = URL(string: "https://api.instagram.com/oauth/authorize/?client_id=\(clientId)&redirect_uri=\(redirectURI)&response_type=token")
        setWebView(
            reguest: getRequest(url: URLValue),
            navigationDelegate: self)
    }
    
    func removeCache() {
        let dataStore = WKWebsiteDataStore.default()
        dataStore.fetchDataRecords(
        ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { (records) in
            
            for record in records {
                dataStore.removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
    
    func getRequest(url: URL?) -> URLRequest {
        return URLRequest(
            url: url!,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: 15.0)
    }
    
    func setWebView(reguest: URLRequest, navigationDelegate: WKNavigationDelegate) {
        webView.navigationDelegate = navigationDelegate
        removeCache()
        webView.load(reguest)
    }
    
}


extension AuthenticationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard
            let urlString =  navigationAction.request.url?.absoluteString,
            urlString.range(of: "#access_token") != nil
            
            else {
                decisionHandler(.allow)
                return
        }
        
        let accessToken = urlString.components(separatedBy: "#access_token=").last!
        self.delegate?.authenticationViewController(self, authorizedWith: accessToken)
        
        decisionHandler(.cancel)
    }
}
