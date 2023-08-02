//
//  NetworkServiceErrors.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

enum NetworkSeviceErrors: Error {
    case noData
    case jsonDecoderError
    case serverError
    case somethingWentWrong(String)
    
    var errorDescription: String {
        switch self {
        case .noData:
            return "Ошибка данных!"
        case .jsonDecoderError:
            return "Ошибка декодирования!"
        case .serverError:
            return "Ошибка сервера!"
        case .somethingWentWrong(let error):
            return error
        }
    }
}
