//
//  FlightDetailVM.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation

protocol FlightDetailVM: AnyObject {
    var stateChange: ((FlightDetailVMImpl.State) -> Void)? { get set }
    func getData()
    func numberOfRows() -> Int
    func cellData(for indexPath: IndexPath) -> AnyCollectionViewCellModelProtocol
}

final class FlightDetailVMImpl: FlightDetailVM {
    
    enum State {
        case loading
        case loaded
        case failLoad(String)
    }
    
    var stateChange: ((State) -> Void)?
    var cellModels: [AnyCollectionViewCellModelProtocol] = []
    private var ticketData: Flight
    private var isLiked: Bool
    private var state: State = .loading {
        didSet {
            self.stateChange?(state)
        }
    }
    
    init(data: Flight, isLiked: Bool) {
        self.ticketData = data
        self.isLiked = isLiked
    }
    
    func getData() {
        
        
        
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
