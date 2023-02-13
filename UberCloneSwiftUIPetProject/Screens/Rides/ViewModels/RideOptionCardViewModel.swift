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
    private(set) var cost: String
    
    init(imageName: String, title: String, cost: String) {
        self.imageName = imageName
        self.title = title
        self.cost = cost
    }
}
