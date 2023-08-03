//
//  ListOfAirTravelVM.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

protocol ListOfAirTravelVM: AnyObject {
    var stateChange: ((ListOfAirTravelVMImpl.State) -> Void)? { get set }
    func numberOfRows() -> Int
    func getData()
    func cellData(for indexPath: IndexPath) -> AnyCollectionViewCellModelProtocol
}

protocol ListOfAirNavigation: AnyObject {
    func goToListOfAir()
    func goToFlightDetail(with data: Flight, and isLiked: Bool)
}

final class ListOfAirTravelVMImpl: ListOfAirTravelVM {
    
    enum State {
        case loading
        case loaded
        case failLoad(String)
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
    
    func numberOfRows() -> Int {
        return cellModels.count
    }
    
    func getData() {
        getCheap { [weak self] models in
            models.flights.forEach {
                let ticketModel = AirTravelCellVM(
                    model: .init(
                        startDate: $0.startDate.getDayAndMonth() ?? "",
                        startCity: $0.startCity,
                        endDate: $0.endDate.getDayAndMonth() ?? "",
                        endCity: $0.endCity,
                        price: "\($0.price)₽"
                    )
                )
                self?.cellModels.append(ticketModel)
                let flightData = $0
                ticketModel.cellTapped = { [weak self] in
                    self?.showFlightDetail(with: flightData, and: false)
                }
            }
        }
    }
    
    func cellData(for indexPath: IndexPath) -> AnyCollectionViewCellModelProtocol {
        return cellModels[indexPath.row]
    }
    
    private func getCheap(completion: @escaping (TicketResponseModel) -> Void) {
        state = .loading
        service.getCheap { [weak self] result in
            switch result {
            case .success(let model):
                completion(.init(flights: model.flights))
                self?.state = .loaded
            case .failure(let error):
                self?.state = .failLoad(error.errorDescription)
            }
        }
    }
    
    private func showListOfAirDetail() {
        navigation?.goToListOfAir()
    }
    
    private func showFlightDetail(with data: Flight, and isLiked: Bool) {
        navigation?.goToFlightDetail(with: data, and: isLiked)
    }
    
}
