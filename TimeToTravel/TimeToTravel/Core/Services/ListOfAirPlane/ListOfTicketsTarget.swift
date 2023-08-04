//
//  ListOfTicketsTarget.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation
import Moya

enum ListOfTicketsTarget {
    case getCheap
}

extension ListOfTicketsTarget: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://vmeste.wildberries.ru")!
    }
    
    var path: String {
        switch self {
        case .getCheap:
            return "/stream/api/avia-service/v1/suggests/getCheap"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCheap:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getCheap:
            return .requestParameters(
                parameters: ["startLocationCode": "LED"],
                encoding: JSONEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        return [
            "accept": "application/json, text/plain, */",
            "content-type": "application/json"
        ]
    }
}
