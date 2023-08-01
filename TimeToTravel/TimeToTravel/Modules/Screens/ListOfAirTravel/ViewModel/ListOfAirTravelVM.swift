//
//  ListOfAirTravelVM.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

protocol ListOfAirTravelVM: AnyObject {
    func numberOfRows() -> Int
    func getData(_ completion: @escaping () -> Void)
    func cellData(for indexPath: IndexPath) -> AnyTableViewCellModelProtocol
}

final class ListOfAirTravelVMImpl: ListOfAirTravelVM {
    
    var cellModels: [AnyTableViewCellModelProtocol] = []
    private let service: AirPlaneServiceProtocol
    
    init() {
        let api = NetworkManager()
        self.service = AirPlaneService(apiManager: api)
    }
    
    func numberOfRows() -> Int {
        return cellModels.count
    }
    
    func getData(_ completion: @escaping () -> Void) {
        
        let emptyModel = EmptyCellVM(.init(height: 15))
        
        getCheap { [weak self] models in
            models.flights.forEach {
                let ticketModel = AirTravelCellVM(
                    model: .init(
                        likeState: false,
                        startDate: $0.startDate,
                        startCity: $0.startCity,
                        endDate: $0.endDate,
                        endCity: $0.endCity,
                        price: $0.price
                    )
                )
                self?.cellModels.append(ticketModel)
                self?.cellModels.append(emptyModel)
            }
            completion()
        }
    }
    
    func cellData(for indexPath: IndexPath) -> AnyTableViewCellModelProtocol {
        return cellModels[indexPath.row]
    }
    
    private func getCheap(completion: @escaping (TicketResponseModel) -> Void) {
        service.getCheap { [weak self] result in
            switch result {
            case .success(let model):
                completion(.init(flights: model.flights))
            case .failure(let error):
                self?.showAlert(
                    title: "Что-то пошло не так",
                    description: error.localizedDescription,
                    buttonTitle: "Хорошо",
                    buttonCallback: nil
                )
            }
        }
    }
    
    private func showAlert(title: String, description: String, buttonTitle: String, buttonCallback: (() -> Void)?) {
        //TODO: - show alertMessage
    }
    
}
