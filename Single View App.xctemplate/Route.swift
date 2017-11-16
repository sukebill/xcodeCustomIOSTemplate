
import UIKit
import SafariServices

public enum RoutePhone: RouteProtocol {
    
    case start
    
    var viewController: UIViewController {
        switch self {
        case .start:
            return StartViewController.instantiate(fromAppStoryboard: .main)
        }
    }
}

fileprivate extension UIViewController {
    
    @objc func dismissAnimated() {
        dismiss(animated: true, completion: nil)
    }
    
}
