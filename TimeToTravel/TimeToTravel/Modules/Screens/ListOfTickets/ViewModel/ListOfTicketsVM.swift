//
//  ListOfAirTravelVM.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

protocol TicketStateDelegate: AnyObject {
    func likeTappedInCell(in ticket: Ticket)
}

protocol ListOfTicketsVM: AnyObject {
    var stateChange: ((ListOfTicketsVMImpl.State) -> Void)? { get set }
    func numberOfRows() -> Int
    func getData()
    func cellData(for indexPath: IndexPath) -> AnyCollectionViewCellModelProtocol
    func likeTappedInCell(ticket: Ticket)
    func showFlightDetail(for index: IndexPath)
}

final class ListOfTicketsVMImpl: ListOfTicketsVM {
    
    enum State {
        case loading
        case loaded
        case failLoad(String)
        case reloadCollection(IndexPath)
    }
    
    var stateChange: ((State) -> Void)?
    var cellModels: [AnyCollectionViewCellModelProtocol] = []
    
    private let service: AirPlaneServiceProtocol
    private let coordinator: ListOfTicketsCoordinateProtocol
    private var state: State = .loading {
        didSet {
            self.stateChange?(state)
        }
    }
    
    init(service: AirPlaneServiceProtocol, coordinator: ListOfTicketsCoordinateProtocol) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func getData() {
        state = .loading
        service.getCheap { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let tickets):
                let models = tickets.map { TicketCellVM(model: $0) }
                self.cellModels = models
                DispatchQueue.main.async {
                    self.state = .loaded
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .failLoad(error.errorDescription)
                }
            }
        }
    }
    
    func numberOfRows() -> Int {
        return cellModels.count
    }
    
    func cellData(for indexPath: IndexPath) -> AnyCollectionViewCellModelProtocol {
        return cellModels[indexPath.row]
    }
    
    func likeTappedInCell(ticket: Ticket) {
        guard let index = cellModels.firstIndex(where: { ($0 as? TicketCellVM)?.model == ticket }),
              let cellVM = cellModels[index] as? TicketCellVM else { return }
        
        cellVM.model.isLiked.toggle()
        state = .reloadCollection(IndexPath(item: index, section: 0))
    }
    
    func showFlightDetail(for index: IndexPath) {
        guard let data = cellModels[index.row] as? TicketCellVM else { return }
        coordinator.goToFlightDetail(data: data.model, delegate: self)
    }
    
}

extension ListOfTicketsVMImpl: TicketStateDelegate {
    func likeTappedInCell(in ticket: Ticket) {
        guard let index = cellModels.firstIndex(where: { ($0 as? TicketCellVM)?.model == ticket }),
              let cellVM = cellModels[index] as? TicketCellVM else { return }
        
        cellVM.model.isLiked.toggle()
        state = .reloadCollection(IndexPath(item: index, section: 0))
    }
}
