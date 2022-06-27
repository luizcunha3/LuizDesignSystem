import UIKit

public extension UIView {
    var ds: DSConstraint {
        return DSConstraint(view: self)
    }
}
