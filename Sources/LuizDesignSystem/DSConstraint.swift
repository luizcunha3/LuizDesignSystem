import UIKit

public class DSConstraint {
    let view: UIView
    private var updatingMode = false
    
    public var width: NSLayoutDimension {
        return view.widthAnchor
    }
    
    public var height: NSLayoutDimension {
        return view.heightAnchor
    }
    
    init(view: UIView) {
        self.view = view
    }
    
    public func applyConstraint(_ block: ((DSConstraint) -> Void)) {
        view.translatesAutoresizingMaskIntoConstraints = false
        block(self)
    }
    
    public func edges(in superView: UIView,
               with offSet: UIEdgeInsets? = nil) {
        let constraints = NSLayoutConstraint.inset(view: self.view, inSuperview: superView, withInset: offSet)
        constraints.activate()
    }
    
    public func edges(in superView: UIView,
               offSet: CGFloat,
               priority: UILayoutPriority = .required) {
        let inset = UIEdgeInsets(top: offSet, left: offSet, bottom: offSet, right: offSet)
        let constraints = NSLayoutConstraint.inset(view: self.view, inSuperview: superView, withInset: inset)
        constraints.forEach {$0.priority = priority}
        constraints.activate()
    }
    
    @discardableResult
    public func top(alignedWith view: UIView,
             relation: NSLayoutConstraintType = .equal,
             offSet: CGFloat = 0,
             priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint.top(firstView: self.view, secondView: view, relation: relation, constant: offSet)
        constraint.priority = priority
        return updatedConstraintIfNeeded(constraint: constraint, offSet: CGFloat(offSet))
    }
    
    @discardableResult
    public func topSafeArea(alignedWith: UIView,
                     relation: NSLayoutConstraintType = .equal,
                     offSet: CGFloat = 0,
                     priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = self.view.topAnchor.constraint(equalTo: alignedWith.safeAreaLayoutGuide.topAnchor,
                                                        constant: offSet)
        constraint.priority = priority
        return updatedConstraintIfNeeded(constraint: constraint, offSet: offSet)
    }
    
    @discardableResult
    public func left(alignedWith view: UIView,
             relation: NSLayoutConstraintType = .equal,
             offSet: CGFloat = 0,
             priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint.left(firstView: self.view, secondView: view, relation: relation, constant: offSet)
        constraint.priority = priority
        return updatedConstraintIfNeeded(constraint: constraint, offSet: CGFloat(offSet))
    }
    
    @discardableResult
    public func under(view: UIView,
               relation: NSLayoutConstraintType = .equal,
               offSet: CGFloat = 0,
               priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint.over(topItem: view,
                                                 bottomItem: self.view,
                                                 relation: relation,
                                                 constant: offSet)
        constraint.priority = priority
        return updatedConstraintIfNeeded(constraint: constraint, offSet: offSet)
    }
    
    private func updatedConstraintIfNeeded(constraint: NSLayoutConstraint, offSet: CGFloat) -> NSLayoutConstraint {
            if updatingMode, let similarConstraint = getSimilarConstraint(to: constraint) {
                similarConstraint.constant = offSet
                return similarConstraint
            }
            constraint.isActive = true
            return constraint
        }
    
    private func getSimilarConstraint(to constraint: NSLayoutConstraint) -> NSLayoutConstraint? {
        if let similarConstraint = view.constraints.first(where: {$0.isSimilar(to: constraint)}){
            return similarConstraint
        }
        return view.superview?.constraints.first { $0.isSimilar(to: constraint)}
    }

}
