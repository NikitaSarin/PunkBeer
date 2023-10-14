//
//  PunkBeerApp.swift
//  PunkBeer
//
//  Created by Nikita Sarin on 14.10.2023.
//

import SwiftUI

@main
struct PunkBeerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: .init(service: NetworkService()))
        }
    }
}
