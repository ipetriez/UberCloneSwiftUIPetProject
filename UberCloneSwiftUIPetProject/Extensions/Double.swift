//
//  Double.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 14.02.23.
//


import Foundation

extension Double {
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func formattedToCurrencyString() -> String {
        currencyFormatter.string(from: self as NSNumber) ?? "$0.00"
    }
}

