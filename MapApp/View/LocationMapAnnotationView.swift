//
//  LocationMapAnnotationView.swift
//  MapApp
//
//  Created by Maulik Shah on 2/7/25.
//

import SwiftUI

struct LocationMapAnnotationView: View {

    var body: some View {
        VStack(spacing: 0.0){
            Image(systemName:"map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30,height: 30)
                .foregroundColor(.white)
                .padding(6)
                .background(.accent)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.accent)
                .frame(width: 10,height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom,40)
            
        }
        
    }
}

#Preview {
    LocationMapAnnotationView()
}
