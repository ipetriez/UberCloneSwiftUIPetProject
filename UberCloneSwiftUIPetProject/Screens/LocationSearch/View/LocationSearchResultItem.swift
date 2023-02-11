//
//  LocationSearchResultItem.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 10.02.23.
//

import SwiftUI

struct LocationSearchResultItem: View {
    var body: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Starbucks coffe")
                    .font(.body)
                
                Text("123 Main street")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.horizontal)
    }
}

struct LocationSearchResultItem_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultItem()
    }
}
