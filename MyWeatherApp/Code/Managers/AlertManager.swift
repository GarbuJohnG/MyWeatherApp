//
//  AlertManager.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import Foundation
import UIKit

struct AlertManager {
    
    func showAlert(withMessage message: String, title: String) {
        guard let topController = UIApplication.topViewController() else { return }
        dismissAnyAlertsPresent()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okBtn)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            topController.present(alert, animated: true, completion: nil)
        })
    }
    
    func dismissAnyAlertsPresent() {
        guard let window = UIApplication.shared.connectedScenes.compactMap({ $0 as? UIWindowScene }).flatMap({ $0.windows }).first else { return }
        guard var topController = window.rootViewController?.presentedViewController else { return }
        while topController.presentedViewController != nil  {
            topController = topController.presentedViewController!
        }
        if topController.isKind(of: UIAlertController.self) {
            topController.dismiss(animated: false, completion: nil)
        }
    }
    
}
