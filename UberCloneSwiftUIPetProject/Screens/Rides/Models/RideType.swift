//
//  RideType.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 14.02.23.
//

import Foundation

enum RideType: Int, CaseIterable, Identifiable {
    case uberX
    case uberBlack
    case uberXL
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .uberX:
            return "UberX"
        case .uberBlack:
            return "UberBlack"
        case .uberXL:
            return "UberXL"
        }
    }
    
    var imageName: String {
        switch self {
        case .uberX:
            return "uber-x"
        case .uberBlack:
            return "uber-black"
        case .uberXL:
            return "uber-x"
        }
    }
    
    var baseFare: Double {
        switch self {
        case .uberX:
            return 5
        case .uberBlack:
            return 20
        case .uberXL:
            return 10
        }
    }
}
