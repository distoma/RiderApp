//
//  SettingsManager.swift
//  RiderApp
//
//  Created by jinseok PARK on 2023/02/14.
//

import Foundation
import Combine

class SettingsManager: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @SettingsDefault(key: "travelRadius", defaultValue: 300)
    var travelRadius: Double {
        willSet {
            objectWillChange.send()
        }
    }
}
