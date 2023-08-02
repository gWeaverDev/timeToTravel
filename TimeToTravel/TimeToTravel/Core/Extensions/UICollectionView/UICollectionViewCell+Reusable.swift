//
//  UICollectionViewCell+Reusable.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String { String(describing: Self.self) }
}
