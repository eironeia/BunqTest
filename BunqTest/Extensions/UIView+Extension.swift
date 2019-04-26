//  Created by Alex Cuello on 25/04/2019.
//  Copyright © 2019 eironeia. All rights reserved.

import UIKit

// MARK: - Constraints
extension UIView {

    func addConstratint(_ constraintString: String, views: [String: AnyObject]) {
        self.addConstratint(constraintString, views: views, metrics: nil)
    }

    func addConstratint(_ constraintString: String, views: [String: AnyObject], metrics: [String: AnyObject]?) {
        addConstraints(
            NSLayoutConstraint.constraints(withVisualFormat: constraintString,
                                           options: [],
                                           metrics: metrics,
                                           views: views))
    }

    func fillSuperview(withEdges edges: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: edges.left),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -edges.right),
            topAnchor.constraint(equalTo: superView.topAnchor, constant: edges.top),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -edges.bottom)
            ])
    }

    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        var anchors = [NSLayoutConstraint]()
        if let top = top { anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant)) }
        if let left = left { anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant)) }
        if let bottom = bottom { anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant)) }
        if let right = right { anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant)) }
        if widthConstant > 0 { anchors.append(widthAnchor.constraint(equalToConstant: widthConstant)) }
        if heightConstant > 0 { anchors.append(heightAnchor.constraint(equalToConstant: heightConstant)) }
        NSLayoutConstraint.activate(anchors)
        return anchors
    }

    func equalWidthToSuperView() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            widthAnchor.constraint(equalTo: superview.widthAnchor).isActive = true
        }
    }

    func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }

    func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }

    func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
    }

    func addSubviewWithAutolayout(_ view: UIView) {
        addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
    }

    func insertSubviewWithAutolayout(_ view: UIView, at index: Int) {
        insertSubview(view, at: index)

        view.translatesAutoresizingMaskIntoConstraints = false
    }

    func addSubviewsWithAutolayoutAndLayoutVertically(_ views: [UIView], spacing: CGFloat = 0.0) {
        views.forEach { view in
            let topAnchor = subviews.last?.bottomAnchor ?? self.topAnchor
            let spacing = subviews.isEmpty ? 0.0 : spacing
            addSubviewWithAutolayout(view)
            view.topAnchor.constraint(equalTo: topAnchor, constant: spacing).isActive = true
        }

        views.last?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
