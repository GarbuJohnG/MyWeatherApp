//
//  ActivityIndicator.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 31/07/2023.
//

import Foundation
import UIKit

class ActivityIndicator {
    
    static let shared = ActivityIndicator()
    private var spinView = UIView()
    
    func showActivity(onView : UIView) {
        
        hideActivity()
        
        spinView = UIView.init(frame: onView.bounds)
        spinView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityindicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        activityindicator.startAnimating()
        activityindicator.center = spinView.center
        
        DispatchQueue.main.async { [weak self] in
            guard let _self = self else { return }
            _self.spinView.addSubview(activityindicator)
            onView.addSubview(_self.spinView)
        }
        
    }
    
    func hideActivity() {
        DispatchQueue.main.async {[weak self] in
            guard let _self = self else { return }
            _self.spinView.removeFromSuperview()
        }
    }
    
}
