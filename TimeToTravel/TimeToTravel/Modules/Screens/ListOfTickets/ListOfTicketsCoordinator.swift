//
//  ListOfTicketsCoordinator.swift
//  TimeToTravel
//
//  Created by George Weaver on 04.08.2023.
//

import UIKit

protocol ListOfTicketsCoordinateProtocol: AnyObject {
    func goToFlightDetail(data: Ticket, delegate: TicketStateDelegate?)
}

final class ListOfTicketsCoordinator: Coordinatable, ListOfTicketsCoordinateProtocol {
    
    var childCoordinators: [Coordinatable] = []
    
    private var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() -> UIViewController {
        let api = NetworkManager()
        let service = AirPlaneService(apiManager: api)
        let viewModel = ListOfTicketsVMImpl(service: service, coordinator: self)
        let vc = ListOfTicketsVC(viewModel: viewModel)
        navigation = UINavigationController(rootViewController: vc)
        return navigation
    }
    
    func goToFlightDetail(data: Ticket, delegate: TicketStateDelegate?) {
        let viewModel = FlightDetailVMImpl(data: data, ticketStateDelegate: delegate)
        let vc = FlightDetailsVC(viewModel: viewModel)
        navigation.pushViewController(vc, animated: true)
    }
}
