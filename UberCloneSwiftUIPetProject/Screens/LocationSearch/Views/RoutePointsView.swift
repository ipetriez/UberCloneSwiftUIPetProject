//
//  RoutePointsView.swift
//  UberCloneSwiftUIPetProject
//
//  Created by Sergey Petrosyan on 13.02.23.
//

import SwiftUI

struct RoutePointsView: View {
    
    private var viewConfig: RoutePointsViewConfig
    
    var body: some View {
        VStack {
            Circle()
                .fill(Color(.systemGray3))
                .frame(width: dimentionForConfig(), height: dimentionForConfig())
            
            Rectangle()
                .fill(Color(.systemGray3))
                .frame(width: 1, height: viewConfig == .regular ? 24 : 32)
            
            Rectangle()
                .fill(Color(.black))
                .frame(width: dimentionForConfig(), height: dimentionForConfig())
        }
    }
    
    init(viewConfig: RoutePointsViewConfig) {
        self.viewConfig = viewConfig
    }
    
    private func dimentionForConfig() -> CGFloat {
        switch viewConfig {
        case .regular:
            return 6
        case .large:
            return 8
        }
    }
}

struct RoutePointsView_Previews: PreviewProvider {
    static var previews: some View {
        RoutePointsView(viewConfig: .regular)
    }
}
