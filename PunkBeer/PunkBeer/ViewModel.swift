//
//  ViewModel.swift
//  PunkBeer
//
//  Created by Nikita Sarin on 14.10.2023.
//

import Foundation
import Combine
import SwiftUI

final class ViewModel: ObservableObject {

    @Published var beers: [Beer]?

    let service: Networking

    init(service: Networking) {
        self.service = service
    }

    @MainActor
    func onAppear() async {
        do {
            beers = try await service.loadBeers()
        } catch {
            print(error)
        }
    }
}
