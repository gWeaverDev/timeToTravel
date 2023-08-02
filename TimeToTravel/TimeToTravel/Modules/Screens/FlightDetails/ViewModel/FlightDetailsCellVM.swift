//
//  FlightDetailsCellVM.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

final class FlightDetailsCellVM: CollectionViewCellModelProtocol {
    
    private let model: FlightDetailCell.Model
    
    init(model: FlightDetailCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: FlightDetailCell) {
        cell.fill(with: model)
    }
}
