//
//  FlightDetailVM.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

protocol FlightDetailVM: AnyObject {
    func getData(_ completion: @escaping () -> Void)
    func numberOfRows() -> Int
    func cellData(for indexPath: IndexPath) -> AnyCollectionViewCellModelProtocol
}

final class FlightDetailVMImpl: FlightDetailVM {
    
    var cellModels: [AnyCollectionViewCellModelProtocol] = []
    private var ticketData: Flight
    private var isLiked: Bool
    
    init(data: Flight, isLiked: Bool) {
        self.ticketData = data
        self.isLiked = isLiked
    }
    
    func getData(_ completion: @escaping () -> Void) {
        
        let detailModel = FlightDetailsCellVM(
            model: .init(
                likeState: isLiked,
                startDate: ticketData.startDate.getDayAndMonth() ?? "",
                startCity: ticketData.startCity,
                endDate: ticketData.endDate.getDayAndMonth() ?? "",
                endCity: ticketData.endCity,
                price: "\(ticketData.price)₽"
            )
        )

        cellModels.append(detailModel)
    }
    
    func numberOfRows() -> Int {
        cellModels.count
    }
    
    func cellData(for indexPath: IndexPath) -> AnyCollectionViewCellModelProtocol {
        return cellModels[indexPath.row]
    }
}
