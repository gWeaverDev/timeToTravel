//
//  AirTravelCellVM.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

final class AirTravelCellVM: TableViewCellModelProtocol {
    
    private let model: AirTravelCell.Model
    
    init(model: AirTravelCell.Model) {
        self.model = model
    }
    
    func configure(_ cell: AirTravelCell) {
        cell.fill(with: self.model)
    }
}
