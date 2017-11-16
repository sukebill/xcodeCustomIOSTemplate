
import UIKit
import CoreLocation

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func instantiate(fromAppStoryboard appStoryboard: AppStoryboard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
    
    var statusBar: UIView? {
        get{
            return UIApplication.shared.value(forKey: "statusBar") as? UIView
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func hideKeyboardWhenTappedAround(_ view: UIView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func hideNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func isLocationEnabled() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                locationAlert()
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
            }
        }else {
            locationAlert()
            return false
        }
    }
    
    func locationAlert() {
        let alert = UIAlertController(title: "", message: "Έχετε απενεργοποιήσει τις υπηρεσίες τοποθεσίας. ", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ενεργοποίηση", style: .default, handler: {
            _ in
            if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }else {
                    // Fallback on earlier versions
                    UIApplication.shared.openURL(appSettings)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

