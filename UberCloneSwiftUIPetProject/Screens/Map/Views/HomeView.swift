//
//  HomeView.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 10.02.23.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: — Private properties
    
    @State private var mapViewState: MapViewState = .noInput
    
    // MARK: — Public properties
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                UberMapViewRepresentable(mapViewState: $mapViewState)
                    .ignoresSafeArea()
                
                if mapViewState == .noInput {
                    LocationSearchActivationView()
                        .padding(.top, 72)
                        .onTapGesture {
                            withAnimation(.spring()) { mapViewState = .searchingForLocation }
                        }
                } else if mapViewState == .searchingForLocation {
                    LocationSearchView(mapViewState: $mapViewState)
                }
                
                MapViewActionButton(mapViewState: $mapViewState)
                    .padding(.top, 4)
                    .padding(.leading)
            }
            
            if mapViewState == .locationSelected || mapViewState == .polylineAdded {
                RequestRideView()
                    .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
