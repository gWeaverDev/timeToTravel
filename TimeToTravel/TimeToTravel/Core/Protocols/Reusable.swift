//
//  Reusable.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
