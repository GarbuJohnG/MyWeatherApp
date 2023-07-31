//
//  UIViewExt.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import UIKit

extension UIView {
    
    @discardableResult
    func manualLayoutable() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    @discardableResult
    func isManualLayoutEnabled(_ isOn: Bool) -> Self {
        return self.apply {
            $0.translatesAutoresizingMaskIntoConstraints = !isOn
        }
    }
    
}
