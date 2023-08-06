//
//  FlightDetailsCellVM.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

final class FlightDetailsCellVM: CollectionViewCellModelProtocol {
    
    //MARK: - Public properties
    var model: Ticket
    
    //MARK: - Lifecycle
    init(model: Ticket) {
        self.model = model
    }
    
    //MARK: - Public methods
    func configure(_ cell: FlightDetailCell) {
        cell.fill(with: model)
    }
}
