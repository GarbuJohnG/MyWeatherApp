//
//  AllMethods.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import UIKit

class AllMethods {
    
    static func is_network_connected() -> Bool {
        let net = NetworkStatus.shared
        return net.isOn
    }
    
    static func get_weather_icon(name: String) -> UIImage {
        var imageName = ""
        switch name {
        case "Clear":
            imageName = "clear"
        case "Rain":
            imageName = "rain"
        case "Clouds","Mist","Haze":
            imageName = "partlysunny"
        default:
            imageName = ""
        }
        return UIImage(named: imageName) ?? UIImage()
    }
    
    static func get_weather_image(name: String) -> UIImage {
        var imageName = ""
        let theme = UserDefaults.standard.string(forKey: THEME_SETTING)
        
        switch name {
        case "Clear":
            imageName = "\(theme?.lowercased() ?? "forest")_sunny"
        case "Rain":
            imageName = "\(theme?.lowercased() ?? "forest")_rainy"
        case "Clouds","Mist","Haze":
            imageName = "\(theme?.lowercased() ?? "forest")_cloudy"
        default:
            imageName = ""
        }
        return UIImage(named: imageName) ?? UIImage()
    }
    
    static func get_weather_color(name: String) -> UIColor {
        var colorName = ""
        let theme = UserDefaults.standard.string(forKey: THEME_SETTING)
        switch name {
        case "Clear":
            colorName = theme == "Sea" ? "seaColor" : "sunnyColor"
        case "Rain":
            colorName = "rainyColor"
        case "Clouds","Mist","Haze":
            colorName = "cloudyColor"
        default:
            colorName = "cloudyColor"
        }
        return UIColor(named: colorName) ?? UIColor()
    }
    
    static func getTopSafeAreaConst() -> CGFloat {
        let window = UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
        let topSafeAreaConst = window?.safeAreaInsets.top ?? 0
        return topSafeAreaConst
        
    }
    
}
