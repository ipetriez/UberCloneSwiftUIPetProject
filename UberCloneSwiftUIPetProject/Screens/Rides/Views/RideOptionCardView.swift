//
//  RideOptionCardView.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 13.02.23.
//

import SwiftUI

struct RideOptionCardView: View {
    
    private(set) var viewModel: RideOptionCardViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(viewModel.imageName)
                .resizable()
                .scaledToFit()
            
            VStack(spacing: 4) {
                Text(viewModel.title)
                    .font(.system(size: 14, weight: .semibold))
                Text(viewModel.cost)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(8)
        }
        .frame(width: 112, height: 140)
        .background(Color(.systemGroupedBackground))
        .cornerRadius(10)
    }
}

struct RideOptionCardView_Previews: PreviewProvider {
    static var previews: some View {
        RideOptionCardView(viewModel: RideOptionCardViewModel(imageName: "uber-x", title: "UberX", cost: "$22.05"))
    }
}
