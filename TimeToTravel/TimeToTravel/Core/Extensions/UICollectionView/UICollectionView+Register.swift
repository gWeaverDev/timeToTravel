//
//  UICollectionView+Register.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit

extension UICollectionView {

    func register<T: Reusable>(cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }

    func register<T: Reusable>(viewType: T.Type) {
        register(viewType.self, forCellWithReuseIdentifier: viewType.reuseIdentifier)
    }
}
