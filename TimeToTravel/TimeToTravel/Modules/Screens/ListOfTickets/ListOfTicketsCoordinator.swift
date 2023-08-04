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

final class ListOfTicketsCoordinator {
    
    //MARK: - Private properties
    private var navigation: UINavigationController
    
    //MARK: - Lifecycle
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}

//MARK: - Coordinatable
extension ListOfTicketsCoordinator: Coordinatable {
    
    func start() -> UIViewController {
        let api = NetworkManager()
        let service = ListOfTicketsService(apiManager: api)
        let viewModel = ListOfTicketsVMImpl(service: service, coordinator: self)
        let vc = ListOfTicketsVC(viewModel: viewModel)
        navigation = UINavigationController(rootViewController: vc)
        return navigation
    }
}

//MARK: - ListOfTicketsCoordinateProtocol
extension ListOfTicketsCoordinator: ListOfTicketsCoordinateProtocol {
    
    func goToFlightDetail(data: Ticket, delegate: TicketStateDelegate?) {
        let viewModel = FlightDetailVMImpl(data: data, ticketStateDelegate: delegate)
        let vc = FlightDetailsVC(viewModel: viewModel)
        navigation.pushViewController(vc, animated: true)
    }
}
