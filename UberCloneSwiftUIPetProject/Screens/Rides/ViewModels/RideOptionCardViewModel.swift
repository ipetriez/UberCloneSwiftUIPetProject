//
//  RideOptionCardViewModel.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 13.02.23.
//

import Foundation
class RideOptionCardViewModel: ObservableObject, Identifiable {
    
    private(set) var imageName: String
    private(set) var title: String
    private(set) var isSelected: Bool
    private var rideType: RideType
    private var distance: Double?
    
    var cost: String {
        guard let distance = distance else { return rideType.baseFare.formattedToCurrencyString() }
        
        let distanceInMiles = distance / 1600
        var multiplier: Double = 0
        
        switch rideType {
        case .uberX:
            multiplier = 1.5
        case .uberBlack:
            multiplier = 2
        case .uberXL:
            multiplier = 1.75
        }
        
        return ((distanceInMiles * multiplier) + rideType.baseFare).formattedToCurrencyString()
    }
    
    init(type: RideType, distance: Double?, isSelected: Bool) {
        self.rideType = type
        self.imageName = type.imageName
        self.title = type.title
        self.distance = distance
        self.isSelected = isSelected
    }
}
