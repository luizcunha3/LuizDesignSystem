import UIKit

open class DSView: UIView {
    
    public func addViews() {
        fatalError("addViews() has not been implemented")
    }
    
    public func setupConstraints() {
        fatalError("setupConstraints() has not been implemented")
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        addViews()
        setupConstraints()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
