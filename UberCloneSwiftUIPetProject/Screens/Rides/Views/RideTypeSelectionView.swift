//
//  RideTypeSelectionView.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 13.02.23.
//

import SwiftUI

struct RideTypeSelectionView: View {
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach(0..<3) { _ in
                    RideOptionCardView(viewModel: RideOptionCardViewModel(imageName: "uber-x", title: "UberX", cost: "$22.05"))
                }
            }
        }
        .padding(.horizontal)
    }
}

struct RideTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        RideTypeSelectionView()
    }
}
