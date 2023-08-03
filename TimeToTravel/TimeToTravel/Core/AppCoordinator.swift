//
//  AppCoordinator.swift
//  TimeToTravel
//
//  Created by George Weaver on 02.08.2023.
//

import Foundation
import UIKit

protocol Coordinatable {
    var parentCoordinator: Coordinatable? { get set }
    var childCoordinators: [Coordinatable] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}

final class AppCoordinator: Coordinatable {
    
    var parentCoordinator: Coordinatable?
    
    var childCoordinators: [Coordinatable] = []
    
    var navigationController: UINavigationController
    
    init(navigController: UINavigationController) {
        self.navigationController = navigController
    }
    
    func start() {
        goToListOfAir()
    }
    
}

extension AppCoordinator: ListOfAirNavigation {
    
    func goToListOfAir() {
        let viewModel = ListOfAirTravelVMImpl(navigation: self)
        let vc = ListOfAirTravelVC(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToFlightDetail(with data: Ticket, delegate: TicketStateDelegate) {
        let viewModel = FlightDetailVMImpl(data: data, ticketStateDelegate: delegate)
        let vc = FlightDetailsVC(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
