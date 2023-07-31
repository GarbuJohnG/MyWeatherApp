//
//  UIViewControllerExt.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 31/07/2023.
//

import UIKit

extension UIViewController {
    
    func setViewBGColor(color: UIColor? = AllMethods.get_weather_color(name: "")) {
        view.backgroundColor = color
    }

}
