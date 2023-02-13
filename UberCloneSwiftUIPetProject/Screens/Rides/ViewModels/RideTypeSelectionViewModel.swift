//
//  RideTypeSelectionViewModel.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 13.02.23.
//

import Foundation

class RideTypeSelectionViewModel: ObservableObject {
    
    @Published var rideOptions: [RideOptionCardViewModel]
    
    init(rideOptions: [RideOptionCardViewModel]) {
        self.rideOptions = rideOptions
    }
}
