//
//  AirPlaneService.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation
import Moya

protocol AirPlaneServiceProtocol: AnyObject {
    func getCheap(completion: @escaping (Result<TicketResponseModel, NetworkSeviceErrors>) -> Void)
}

final class AirPlaneService: AirPlaneServiceProtocol {
    
    private let apiManager: NetworkManager
    
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    init(apiManager: NetworkManager) {
        self.apiManager = apiManager
    }
    
    func getCheap(completion: @escaping (Result<TicketResponseModel, NetworkSeviceErrors>) -> Void) {
        apiManager.request(AirPlaneTarget.getCheap) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200:
                    guard let model = try? response.map(TicketResponseModel.self) else {
                        completion(.failure(.jsonDecoderError))
                        return
                    }
                    completion(.success(.init(flights: model.flights)))
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
