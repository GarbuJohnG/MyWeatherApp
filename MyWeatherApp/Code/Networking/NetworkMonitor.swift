//
//  NetworkMonitor.swift
//  MyWeatherApp
//
//  Created by Gabriel John on 27/07/2023.
//

import Foundation
import Network

public enum ConnectionType {
    case wifi
    case ethernet
    case cellular
    case unknown
}

class NetworkStatus {
    
    static public let shared = NetworkStatus()
    
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    var isOn: Bool = true
    var connType: ConnectionType = .wifi

    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }

    // Start Network Monitoring
    
    func start() {
        self.monitor.pathUpdateHandler = { path in
            self.isOn = path.status == .satisfied
            self.connType = self.checkConnectionTypeForPath(path)
        }
    }

    // Stop Network Monitoring
    
    func stop() {
        self.monitor.cancel()
    }

    // Check Network Connection type
    
    func checkConnectionTypeForPath(_ path: NWPath) -> ConnectionType {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .ethernet
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        }

        return .unknown
    }
    
}
