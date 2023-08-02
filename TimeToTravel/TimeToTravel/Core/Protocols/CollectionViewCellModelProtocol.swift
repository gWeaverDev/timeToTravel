//
//  CollectionViewCellModelProtocol.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit

protocol AnyCollectionViewCellModelProtocol: AnyReusableViewModelProtocol {

    func configureAny(_ cell: UICollectionViewCell)
}

protocol CollectionViewCellModelProtocol: AnyCollectionViewCellModelProtocol {

    associatedtype CellType: UICollectionViewCell

    func configure(_ cell: CellType)
}

extension CollectionViewCellModelProtocol {

    static var viewClass: UIView.Type {
        return CellType.self
    }

    func configureAny(_ cell: UICollectionViewCell) {
        guard let cell = cell as? CellType else {
            assertionFailure()
            return
        }
        configure(cell)
    }
}
