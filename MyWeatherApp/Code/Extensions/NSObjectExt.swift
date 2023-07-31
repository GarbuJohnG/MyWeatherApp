//
//  NSObjectExt.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import Foundation

protocol HasApply { }

extension HasApply {

    @discardableResult
    func apply(closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }

}

extension NSObject: HasApply { }

extension NSObjectProtocol {
    
    static var name: String {
        return String(describing: self)
    }
    
}

