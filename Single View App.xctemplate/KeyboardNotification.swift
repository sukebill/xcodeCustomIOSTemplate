
import UIKit

enum KeyboardNotificationError : Error {
    case InfoDictionaryMissing
    case animationDurationMissing
    case keyboardEndFrameMissing
}

struct KeyboardNotification {
    let animationDuration : Double
    let keyboardEndFrame : CGRect
    let rawAnimationCurve : UInt32
    let animationCurve : UIViewAnimationOptions
    
    init(notification: NSNotification) throws {
        
        guard let userInfo = notification.userInfo else {
            throw KeyboardNotificationError.InfoDictionaryMissing
        }
        
        guard let keyboardEndFrameVal = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
            throw KeyboardNotificationError.keyboardEndFrameMissing
        }
        guard let animationDurationVal = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else {
            throw KeyboardNotificationError.animationDurationMissing
            
        }
        guard let rawAnimationCurveVal = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber else {
            throw KeyboardNotificationError.animationDurationMissing
        }
        
        keyboardEndFrame = keyboardEndFrameVal.cgRectValue
        animationDuration = animationDurationVal.doubleValue
        rawAnimationCurve = rawAnimationCurveVal.uint32Value << 16
        animationCurve = UIViewAnimationOptions.init(rawValue: UInt(rawAnimationCurve))
    }
    
    func convertedKeyboardEndFrame(view: UIView) -> CGRect {
        return view.convert(keyboardEndFrame, from: view.window)
    }
}
