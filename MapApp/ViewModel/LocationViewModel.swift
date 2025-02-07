//
//  LocationViewModel.swift
//  MapApp
//
//  Created by Maulik Shah on 2/7/25.
//

import Foundation

class LocationViewModel : ObservableObject {
    @Published var locations : [Location]
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
    }
}
