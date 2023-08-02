//
//  UICollectionView+ViewModel.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit

extension UICollectionView {
    
    func registerCells(withModels models: AnyCollectionViewCellModelProtocol.Type...) {
        models.forEach {
            register(cellType: $0.viewClass)
        }
    }

    func dequeueReusableCell(withModel model: AnyCollectionViewCellModelProtocol, for indexPath: IndexPath) -> UICollectionViewCell {
        dequeueReusableCell(withReuseIdentifier: type(of: model).reuseIdentifier, for: indexPath)
    }
}
