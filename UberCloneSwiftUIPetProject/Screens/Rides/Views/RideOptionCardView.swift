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
            
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.title)
                    .font(.system(size: 14, weight: .semibold))
                Text(viewModel.cost)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding()
        }
        .frame(width: 112, height: 140)
        .foregroundColor(Color(viewModel.isSelected ? .white : .black))
        .background(Color(viewModel.isSelected ? .systemBlue : .systemGroupedBackground))
        .scaleEffect(viewModel.isSelected ? 1.2 : 1.0)
        .cornerRadius(10)
    }
}

struct RideOptionCardView_Previews: PreviewProvider {
    static var previews: some View {
        RideOptionCardView(viewModel: RideOptionCardViewModel(imageName: "uber-x", title: "UberX", cost: "$22.05", isSelected: false))
    }
}
