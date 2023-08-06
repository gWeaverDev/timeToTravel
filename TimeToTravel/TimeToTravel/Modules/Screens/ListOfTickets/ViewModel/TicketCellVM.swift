//
//  TicketCellVM.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

final class TicketCellVM: CollectionViewCellModelProtocol {
    
    //MARK: - Public propertios
    var model: Ticket
    
    //MARK: - Lifecycle
    init(model: Ticket) {
        self.model = model
    }
    
    //MARK: - Public methods
    func configure(_ cell: TicketCell) {
        cell.fill(with: model)
    }
}
