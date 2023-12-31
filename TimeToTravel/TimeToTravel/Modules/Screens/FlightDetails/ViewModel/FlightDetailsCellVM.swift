//
//  FlightDetailsCellVM.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

final class FlightDetailsCellVM: CollectionViewCellModelProtocol {
    
    var model: Ticket
    
    init(model: Ticket) {
        self.model = model
    }
    
    func configure(_ cell: FlightDetailCell) {
        cell.fill(with: model)
    }
}
