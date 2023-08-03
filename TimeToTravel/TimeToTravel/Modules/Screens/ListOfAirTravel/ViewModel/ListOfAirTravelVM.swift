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

protocol ListOfAirTravelVM: AnyObject {
    var stateChange: ((ListOfAirTravelVMImpl.State) -> Void)? { get set }
    func numberOfRows() -> Int
    func getData()
    func cellData(for indexPath: IndexPath) -> AnyCollectionViewCellModelProtocol
    func likeTappedInCell(ticket: Ticket)
}

protocol ListOfAirNavigation: AnyObject {
    func goToListOfAir()
    func goToFlightDetail(with data: Ticket, delegate: TicketStateDelegate)
}

final class ListOfAirTravelVMImpl: ListOfAirTravelVM {
    
    enum State {
        case loading
        case loaded
        case failLoad(String)
        case reloadCollection(IndexPath)
    }
    
    weak var navigation: ListOfAirNavigation?
    
    var stateChange: ((State) -> Void)?
    var cellModels: [AnyCollectionViewCellModelProtocol] = []
    
    private let service: AirPlaneServiceProtocol
    private var state: State = .loading {
        didSet {
            self.stateChange?(state)
        }
    }
    
    init(navigation: ListOfAirNavigation) {
        let api = NetworkManager()
        self.service = AirPlaneService(apiManager: api)
        self.navigation = navigation
    }
    
    func getData() {
        state = .loading
        service.getCheap { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let tickets):
                let models = tickets.map {
                    let cellVM = AirTravelCellVM(model: $0)
                    cellVM.cellTapped = {
                        self.showFlightDetail(with: cellVM.model)
                    }
                    return cellVM
                }
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
        guard let index = cellModels.firstIndex(where: { ($0 as? AirTravelCellVM)?.model == ticket }),
              let cellVM = cellModels[index] as? AirTravelCellVM else { return }
        
        cellVM.model.isLiked.toggle()
        state = .reloadCollection(IndexPath(item: index, section: 0))
    }
    
    private func showListOfAirDetail() {
        navigation?.goToListOfAir()
    }
    
    private func showFlightDetail(with data: Ticket) {
        navigation?.goToFlightDetail(with: data, delegate: self)
    }
    
}

extension ListOfAirTravelVMImpl: TicketStateDelegate {
    func likeTappedInCell(in ticket: Ticket) {
        guard let index = cellModels.firstIndex(where: { ($0 as? AirTravelCellVM)?.model == ticket }),
              let cellVM = cellModels[index] as? AirTravelCellVM else { return }
        
        cellVM.model.isLiked.toggle()
        state = .reloadCollection(IndexPath(item: index, section: 0))
    }
}
