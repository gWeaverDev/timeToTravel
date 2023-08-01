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
        
        let ticketModel = AirTravelCellVM(
            model: .init(
                likeState: false,
                startDate: "1 августа",
                startCity: "Санкт-Петербург",
                endDate: "2 августа",
                endCity: "Москва",
                price: "42600₽")
        )
        
        cellModels.append(ticketModel)
    }
    
    func cellData(for indexPath: IndexPath) -> AnyTableViewCellModelProtocol {
        return cellModels[indexPath.row]
    }
    
    private func getCheap(completion: @escaping (TicketResponseModel) -> Void) {
        service.getCheap { [weak self] result in
            switch result {
            case .success(let model):
                completion(.init(data: model.data))
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
