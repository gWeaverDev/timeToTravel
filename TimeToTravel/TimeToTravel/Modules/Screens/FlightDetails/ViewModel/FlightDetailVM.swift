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
    func likeTappedInCell(for ticket: Ticket)
}

final class FlightDetailVMImpl: FlightDetailVM {
    
    enum State {
        case reloadCollection
    }
    
    //MARK: - Public properties
    weak var delegate: TicketStateDelegate?
    
    var stateChange: ((State) -> Void)?
    var cellModels: [AnyCollectionViewCellModelProtocol] = []
    
    //MARK: - Private properties
    private var ticketData: Ticket
    private var state: State = .reloadCollection {
        didSet {
            self.stateChange?(state)
        }
    }
    
    //MARK: - Lifecycle
    init(data: Ticket, ticketStateDelegate: TicketStateDelegate?) {
        self.ticketData = data
        self.delegate = ticketStateDelegate
    }
    
    //MARK: - Public methods
    func getData() {
        let detailModel = FlightDetailsCellVM(model: ticketData)
        cellModels.append(detailModel)
    }
    
    func numberOfRows() -> Int {
        cellModels.count
    }
    
    func cellData(for indexPath: IndexPath) -> AnyCollectionViewCellModelProtocol {
        return cellModels[indexPath.row]
    }
    
    func likeTappedInCell(for ticket: Ticket) {
        guard let index = cellModels.firstIndex(where: { ($0 as? FlightDetailsCellVM)?.model == ticket }),
              let detailModel = cellModels[index] as? FlightDetailsCellVM else { return }
        
        detailModel.model.isLiked.toggle()
        delegate?.isLiked(in: ticket)
        
        state = .reloadCollection
    }
}
