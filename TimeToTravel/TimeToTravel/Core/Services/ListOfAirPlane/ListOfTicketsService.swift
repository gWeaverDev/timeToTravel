//
//  ListOfTicketsService.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation
import Moya

protocol ListOfTicketsServiceProtocol: AnyObject {
    func getCheap(completion: @escaping (Result<[Ticket], NetworkSeviceErrors>) -> Void)
}

final class ListOfTicketsService: ListOfTicketsServiceProtocol {
    
    private let apiManager: NetworkManager
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    init(apiManager: NetworkManager) {
        self.apiManager = apiManager
    }
    
    func getCheap(completion: @escaping (Result<[Ticket], NetworkSeviceErrors>) -> Void) {
        apiManager.request(ListOfTicketsTarget.getCheap) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200:
                    guard let model = try? response.map(TicketResponseModel.self) else {
                        completion(.failure(.jsonDecoderError))
                        return
                    }
                    let tickets = model.flights.map {
                        Ticket(
                            startDate: $0.startDate.getDayAndMonth() ?? "",
                            endDate: $0.endDate.getDayAndMonth() ?? "",
                            startCity: $0.startCity,
                            endCity: $0.endCity,
                            price: "\($0.price)₽",
                            isLiked: false
                        )
                    }
                    completion(.success(tickets))
                case 400...499:
                    completion(.failure(.noData))
                default:
                    completion(.failure(.serverError))
                }
            case .failure(let error):
                completion(.failure(.somethingWentWrong(error.localizedDescription)))
            }
        }
    }
}
