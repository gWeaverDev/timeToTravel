//
//  EmptyCellVM.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

final class EmptyCellVM: TableViewCellModelProtocol {

    private var model: EmptyCell.Model

    var height: CGFloat {
        model.height
    }

    init(_ model: EmptyCell.Model) {
        self.model = model
    }

    func configure(_ cell: EmptyCell) {
        cell.configure(with: model)
    }

    func setHeight(height: CGFloat) {
        model.setHeight(height: height)
    }
}
