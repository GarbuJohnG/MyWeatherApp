//
//  NSLayoutExt.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import UIKit

extension NSLayoutAnchor {

    @discardableResult
    @objc func equal(
        to other: NSLayoutAnchor<AnchorType>,
        constant: CGFloat = 0.0,
        withPriority priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        let newConstraint = constraint(equalTo: other, constant: constant)
        newConstraint.priority = priority
        newConstraint.activate()
        return newConstraint
    }

    @discardableResult
    @objc func greaterThanOrEqual(
        to other: NSLayoutAnchor<AnchorType>,
        constant: CGFloat = 0.0,
        withPriority priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        let newConstraint = constraint(greaterThanOrEqualTo: other, constant: constant)
        newConstraint.priority = priority
        newConstraint.activate()
        return newConstraint
    }

    @discardableResult
    @objc func lessThanOrEqual(
        to other: NSLayoutAnchor<AnchorType>,
        constant: CGFloat = 0.0,
        withPriority priority: UILayoutPriority = .required
    ) -> NSLayoutConstraint {
        let newConstraint = constraint(lessThanOrEqualTo: other, constant: constant)
        newConstraint.priority = priority
        newConstraint.activate()
        return newConstraint
    }

}

extension NSLayoutConstraint {
    
    @discardableResult
    func activate() -> Self {
        isActive = true
        return self
    }
    
    @discardableResult
    func withMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: self.firstItem as Any,
            attribute: self.firstAttribute,
            relatedBy: self.relation,
            toItem: self.secondItem,
            attribute: self.secondAttribute,
            multiplier: multiplier,
            constant: self.constant
        )
    }
    
    @discardableResult
    func withPriority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
}

extension NSLayoutDimension {
    
    @discardableResult
    @objc func equalTo(constant: CGFloat, withPriority priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let newConstraint = constraint(equalToConstant: constant)
        newConstraint.priority = priority
        newConstraint.activate()
        return newConstraint
    }
    
}
