//
//  NetworkResponseModel.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

struct NetworkResponseErrorModel: Decodable {
    let errors: NetworkResponseError?
}

struct NetworkResponseError: Decodable {
    let title: String?
    let status: Int
    let source: NetworkResponseErrorPointer?
    let detail: String?
}

struct NetworkResponseErrorPointer: Decodable {
    let pointer: String?
}

struct NetworkErrorMessage: Error {
    let message: String?
}
