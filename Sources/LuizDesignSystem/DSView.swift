import UIKit

class DSView: UIView {
    
    func addViews() {
        fatalError("addViews() has not been implemented")
    }
    
    func setupConstraints() {
        fatalError("setupConstraints() has not been implemented")
    }
    
    init() {
        super.init(frame: CGRect.zero)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
