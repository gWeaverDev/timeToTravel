//
//  UIView+Layout.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import UIKit

extension UIView {
    
    func addSubviewsWithoutAutoresizing(_ subviews: UIView...) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}
