//
//  AppCoordinator.swift
//  TimeToTravel
//
//  Created by George Weaver on 02.08.2023.
//

import Foundation
import UIKit

protocol Coordinatable {
    var childCoordinators: [Coordinatable] { get set }
    func start() -> UIViewController
}

final class AppCoordinator: Coordinatable {
    
    var childCoordinators: [Coordinatable] = []
    
    func start() -> UIViewController {
        let listOfTicketsCoordinator = ListOfTicketsCoordinator(navigation: UINavigationController())
        childCoordinators.append(listOfTicketsCoordinator)
        return listOfTicketsCoordinator.start()
    }
    
}
