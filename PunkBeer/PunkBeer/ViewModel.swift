//
//  ViewModel.swift
//  PunkBeer
//
//  Created by Nikita Sarin on 14.10.2023.
//

import Foundation
import Observation
import SwiftUI

@Observable final class ViewModel: ObservableObject {

    var beers: [Beer]?

    let service: Networking & ImageFetching

    init(service: Networking & ImageFetching) {
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
