//
//  AlertManager.swift
//  TimeToTravel
//
//  Created by George Weaver on 03.08.2023.
//

import UIKit

final class AlertManager {
    
    static let shared = AlertManager()
    
    //MARK: - Lifecycle
    init () {}
    
    //MARK: - Public methods
    func presentAlert(for viewController: UIViewController, _ text: String) {
        
        let alertController = UIAlertController(title: "Ошибка", message: text, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Хорошо", style: .default)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true)
    }
    
}
