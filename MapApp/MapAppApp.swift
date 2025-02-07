//
//  MapAppApp.swift
//  MapApp
//
//  Created by Maulik Shah on 2/7/25.
//

import SwiftUI

@main
struct MapAppApp: App {
    @StateObject private var vm = LocationViewModel()
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}
