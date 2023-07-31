//
//  UITableViewExt.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import Foundation
import UIKit

open class ReusableTableViewCell: UITableViewCell {
    
    // Reuse Identifier String
    
    public class var reuseIdentifier: String {
        return "\(self.self)"
    }
    
    // Registers the Nib with the provided table
    
    public static func registerWithTable(_ table: UITableView) {
        table.register(self.self, forCellReuseIdentifier: self.reuseIdentifier)
    }
    
}
