//
//  NetworkManager.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation
import Moya

final class NetworkManager {
    
    private let manager: Session
    private let provider: MultiMoyaProvider
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 300
        configuration.waitsForConnectivity = true

        manager = Session(configuration: configuration)
        let loggerPlugin = NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))
        provider = MultiMoyaProvider(callbackQueue: DispatchQueue.main, session: manager, plugins: [loggerPlugin])
    }

    func request(_ target: TargetType, completion: @escaping (Result<Response, MoyaError>) -> Void) {
        provider.multiRequest(MultiTarget(target), completion: completion)
    }
}
