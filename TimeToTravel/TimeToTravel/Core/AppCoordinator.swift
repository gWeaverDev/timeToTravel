//
//  AppCoordinator.swift
//  TimeToTravel
//
//  Created by George Weaver on 02.08.2023.
//

import Foundation
import UIKit

protocol Coordinatable {
    func start() -> UIViewController
}

final class AppCoordinator {
    
    //MARK: - Public properties
    var childCoordinators: [Coordinatable] = []
}

//MARK: - Coordinatable
extension AppCoordinator: Coordinatable {
    
    func start() -> UIViewController {
        let listOfTicketsCoordinator = ListOfTicketsCoordinator(navigation: UINavigationController())
        childCoordinators.append(listOfTicketsCoordinator)
        return listOfTicketsCoordinator.start()
    }
}
