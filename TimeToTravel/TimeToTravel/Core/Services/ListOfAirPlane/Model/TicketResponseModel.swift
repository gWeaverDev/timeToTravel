//
//  TicketRequestModel.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

struct TicketResponseModel: Codable {
    let flights: [Flight]
}

struct Flight: Codable {
    let startDate: String
    let endDate: String
    let startCity: String
    let endCity: String
    let price: Int
}


