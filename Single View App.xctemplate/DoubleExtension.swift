
import Foundation

extension Double {
    
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var degreesToRadians: Double {
        return self * .pi / 180
    }
    var radiansToDegrees: Double {
        return self * 180 / .pi
    }
}
