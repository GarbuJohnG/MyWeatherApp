//
//  AlertManager.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import Foundation
import UIKit

struct AlertManager {
  
  let rootController: UIViewController? = {
    let app = UIApplication.shared.delegate as! SceneDelegate
    return app.window?.rootViewController
  }()
  
  func showAlert(withMessage message: String, title: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okBtn = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
    alert.addAction(okBtn)
    rootController?.present(alert, animated: true, completion: nil)
  }
  
}
