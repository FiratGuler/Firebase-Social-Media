//
//  AlertHelper.swift
//  FirebaseTask
//
//  Created by Fırat Güler on 7.10.2024.
//

import UIKit


class AlertHelper {
    
    static func showAlert(viewController: UIViewController, title: String, message: String, actionTitle: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            completion?()
        }
        
        alertController.addAction(action)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
