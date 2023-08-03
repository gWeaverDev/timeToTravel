//
//  AirTravelCellVM.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

final class AirTravelCellVM: CollectionViewCellModelProtocol {
    
    var cellTapped: (() -> Void)?
    
    var model: Ticket
    
    init(model: Ticket) {
        self.model = model
    }
    
    func configure(_ cell: AirTravelCell) {
        cell.fill(with: model)
        cell.routing = cellTapped
    }
}
