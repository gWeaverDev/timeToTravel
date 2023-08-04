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
    func likeTappedInCell()
}

final class FlightDetailVMImpl: FlightDetailVM {
    
    enum State {
        case isLiked
    }
    
//    weak var delegate: ListOfAirTravelDelegate?
//    weak var ticketStateDelegate: TicketStateDelegate?
    weak var delegate: TicketStateDelegate?
    
    var stateChange: ((State) -> Void)?
    var cellModels: [AnyCollectionViewCellModelProtocol] = []
    
    private var ticketData: Ticket
    private var state: State = .isLiked {
        didSet {
            self.stateChange?(state)
        }
    }
    
    init(data: Ticket, ticketStateDelegate: TicketStateDelegate?) {
        self.ticketData = data
        self.delegate = ticketStateDelegate
    }
    
    func getData() {
        let detailModel = FlightDetailsCellVM(
            model: .init(
                startDate: ticketData.startDate.getDayAndMonth() ?? "",
                endDate: ticketData.endDate.getDayAndMonth() ?? "",
                startCity: ticketData.startCity,
                endCity: ticketData.endCity,
                price: ticketData.price,
                isLiked: ticketData.isLiked
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
    
    func likeTappedInCell() {
        delegate?.likeTappedInCell(in: ticketData)
    }
}
