//
//  LocationViewModel.swift
//  MapApp
//
//  Created by Maulik Shah on 2/7/25.
//

import SwiftUI
import MapKit

class LocationViewModel : ObservableObject {
    
    // All loaded locations
    @Published var locations : [Location]
    
    // current location on map
    @Published var mapLocation: Location{
        didSet{
            updateMapRegion(location: mapLocation)
        }
    }
    
    // current region on map
    @Published var mapRegion : MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.2)
    
    //show list of location
    @Published var showLocationList : Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
    }
    
    private func updateMapRegion(location : Location) {
        mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
    }
    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList = !showLocationList
        /// also you can use toggle.
        }
    }
    
    func showNextLocation(location: Location){
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed(){
        // get the current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else{
            print("Could not find current index in locations array")
            return
        }
        // check if the currentIdex is the valid
        let nextIndex = currentIndex + 1
        
        guard locations.indices.contains(nextIndex) else {
            // next index  is not valid restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        let nextLoction = locations[nextIndex]
        showNextLocation(location: nextLoction)
    }
}
