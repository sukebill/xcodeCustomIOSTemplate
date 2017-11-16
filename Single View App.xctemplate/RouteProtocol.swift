
import Foundation
import UIKit

protocol RouteProtocol {
    
    var viewController: UIViewController { get }
    
    // Override if necessary
    func configure(navigationController: UINavigationController)
    func configureCloseButton(viewController: UIViewController)
}

extension RouteProtocol {
    
    func presentFrom(_ viewController: UIViewController, animated: Bool = true, completion: (() -> Swift.Void)? = nil) {
        viewController.present(self.viewController, animated: animated, completion: completion)
    }
    
    func pushFrom(_ viewController: UIViewController, animated: Bool = true) {
        viewController.navigationController?.pushViewController(self.viewController, animated: animated)
    }
    
    func replace(_ viewController: UIViewController, animated: Bool = true) {
        assert(viewController.navigationController != nil)
        guard let navigationController = viewController.navigationController else { return }
        
        var vcs = Array(navigationController.viewControllers.dropLast())
        vcs.append(self.viewController)
        
        navigationController.setViewControllers(vcs, animated: animated)
    }
    
    func replaceNavigationStack(_ viewController: UIViewController, animated: Bool = true) {
        assert(viewController.navigationController != nil)
        viewController.navigationController?.setViewControllers([self.viewController], animated: animated)
    }
}

extension RouteProtocol {
    
    // Do nothing. Override in subclasses
    func configure(navigationController: UINavigationController) {
        
    }

    // Do nothing. Override in subclasses
    func configureCloseButton(viewController: UIViewController) {
        
    }
}
