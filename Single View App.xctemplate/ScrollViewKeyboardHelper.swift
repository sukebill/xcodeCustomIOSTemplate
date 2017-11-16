
import UIKit

class ScrollViewKeyboardHelper {

    var keyboardWillAppearAction: (KeyboardNotification) -> () = { _ in }
    var keyboardWillHideAction: (KeyboardNotification) -> () = { _ in }

    private(set) weak var view : UIView?
    private(set) weak var scrollView : UIScrollView?
    private(set) var keyboardIsVisible = false
    private(set) var isTablet: Bool
    
    required init(view : UIView, scrollView: UIScrollView, isTablet: Bool) {
        self.view = view
        self.scrollView = scrollView
        self.isTablet = isTablet
    }
    
    func viewWillAppear() {
        guard !isTablet else {
            return
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: .UIKeyboardWillHide, object: nil)
    }
    
    func viewWillDisappear() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - Notifications
    
    @objc func keyboardWillShowNotification(notification: NSNotification) {
        keyboardIsVisible = true
        
        guard let keybNotification = try? KeyboardNotification(notification: notification),
            let scrollView = scrollView,
            let view = view else {
                return
        }
        
        keyboardWillAppearAction(keybNotification)
        
        let overlapHeight = scrollView.frame.maxY - keybNotification.convertedKeyboardEndFrame(view: view).minY
        scrollView.contentInset.bottom = overlapHeight
        scrollView.scrollIndicatorInsets.bottom = overlapHeight
    }
    
    @objc func keyboardWillHideNotification(notification: NSNotification) {
        keyboardIsVisible = false
        
        scrollView?.contentInset.bottom = 0
        scrollView?.scrollIndicatorInsets.bottom = 0
        
        if let keybNotification = try? KeyboardNotification(notification: notification) {
            keyboardWillHideAction(keybNotification)
        }
    }
}
