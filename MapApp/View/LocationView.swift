//
//  LocationView.swift
//  MapApp
//
//  Created by Maulik Shah on 2/7/25.
//

import SwiftUI
import MapKit


struct LocationView: View {
 
    @EnvironmentObject private var vm : LocationViewModel
    
    var body: some View {
        ZStack{
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Header
                    .padding()
                Spacer()
                locationsPreviewStack
            }
        }
    }
}

extension LocationView{
    private var Header: some View{
        VStack{
           
            Button {
                vm.toggleLocationList()
            } label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.black)
                    .frame(height : 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none,value: vm.mapLocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(.black)
                            .padding()
                            .rotationEffect(.degrees(vm.showLocationList ? 180 : 0))
                    }
            }
            
            if vm.showLocationList{
                LocationListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.3), radius: 10,x:0 , y : 15)
    }
    
    private var mapLayer: some View{
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations, annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var locationsPreviewStack : some View{
        ZStack{
            ForEach(vm.locations){location in
                if vm.mapLocation == location{
                    LocationPreviewView(location: location)
                        .shadow(color: .black.opacity(0.3), radius:20)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                       
                }
            }
        }
    }
}


#Preview {
    LocationView()
        .environmentObject(LocationViewModel())
}
