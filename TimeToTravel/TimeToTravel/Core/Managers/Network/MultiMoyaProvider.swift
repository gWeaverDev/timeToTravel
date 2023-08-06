//
//  MultiMoyaProvider.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation
import Moya

final class MultiMoyaProvider: MoyaProvider<MultiTarget> {
    
    typealias Target = MultiTarget
    
    //MARK: - Lifecycle
    override init(
        endpointClosure: @escaping MoyaProvider<MultiTarget>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
        requestClosure: @escaping MoyaProvider<MultiTarget>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
        stubClosure: @escaping MoyaProvider<MultiTarget>.StubClosure = MoyaProvider<Target>.neverStub,
        callbackQueue: DispatchQueue? = nil,
        session: Session,
        plugins: [PluginType] = [],
        trackInflights: Bool = false
    ) {
        super.init(
            endpointClosure: endpointClosure,
            requestClosure: requestClosure,
            stubClosure: stubClosure,
            callbackQueue: callbackQueue,
            session: session,
            plugins: plugins,
            trackInflights: trackInflights
        )
    }
}
