//
//  LocationSearchView.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 10.02.23.
//

import SwiftUI

struct LocationSearchView: View {
    
    // MARK: — Private properties
    
    @State private var startPoint = ""
    @EnvironmentObject private var locationSearchViewModel: LocationSearchViewModel
    
    // MARK: — Public properties
    
    @Binding var mapViewState: MapViewState
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width: 6, height: 6)
                }
                
                VStack {
                    TextField("Current location", text: $startPoint)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    
                    TextField("Where to?", text: $locationSearchViewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
            }
            .padding(.top, 64)
            .padding(.horizontal)
            
            Divider().padding(.vertical)
            
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(locationSearchViewModel.results, id: \.self) { result in
                        LocationSearchResultItem(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                locationSearchViewModel.selectLocation(result)
                                mapViewState = .locationSelected
                            }
                    }
                }
            }
        }
        .background(.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapViewState: .constant(.searchingForLocation))
    }
}
