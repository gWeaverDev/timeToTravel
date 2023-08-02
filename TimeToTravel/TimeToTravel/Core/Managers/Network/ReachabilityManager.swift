//
//  ReachabilityManager.swift
//  TimeToTravel
//
//  Created by George Weaver on 01.08.2023.
//

import Foundation
import Alamofire

class ReachabilityManager {

    static let shared = ReachabilityManager()

    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    var isReachable = false
    
    func startNetworkReachabilityObserver() {

    reachabilityManager?.startListening { status in
        switch status {
        case .notReachable:
            return
            //TODO: - make error messages
        case .unknown:
            return
        case .reachable(.ethernetOrWiFi):
            return
        case .reachable(.cellular):
            return
            }
        }
    }
}

