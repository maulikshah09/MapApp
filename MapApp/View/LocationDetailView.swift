//
//  LocationDetailView.swift
//  MapApp
//
//  Created by Maulik Shah on 2/8/25.
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    @Environment(\.dismiss) var dismiss
    let location : Location
    @EnvironmentObject private var locationViewModel : LocationViewModel
    
    var body: some View {
        ScrollView{
            VStack{
                imageSection
                    .shadow(color: .black.opacity(0.3), radius: 20,x: 0,y:10)
                
                VStack(alignment: .leading, spacing: 16.0){
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding()
            }
        }
        .ignoresSafeArea()
        .background(.ultraThinMaterial)
        .overlay(alignment: .topLeading) {
            Button {
                //dismiss()
                locationViewModel.sheetLocation = nil  // this one also works
            } label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(16)
                    .foregroundStyle(Color(UIColor.label))
                    .background(.thinMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 4)
                    .padding()
            }

        }
    }
}

extension LocationDetailView{
    private var imageSection : some View {
        TabView {
            ForEach(location.imageNames,id: \.self) { image in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
       // .cornerRadius(20)
       // .padding()
        .tabViewStyle(.page)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8.0){
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8.0){
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let url  = URL(string: location.link){
                Link("Read more on Wikipedia", destination: url)
                    .font(.headline)
                    .tint(.blue)
            }
        }
    }
    
    private var mapLayer: some View{
        Map(coordinateRegion: .constant(MKCoordinateRegion(center: location.coordinates, span: locationViewModel.mapSpan)),
            annotationItems: [location]) { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                                   .shadow(radius: 10)
            }
        }
            .aspectRatio(contentMode: .fit)
            .cornerRadius(30)
            .padding(.bottom,20)
           // .disabled(true)
            .allowsHitTesting(false)
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationViewModel())
}
