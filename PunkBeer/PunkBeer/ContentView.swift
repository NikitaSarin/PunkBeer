//
//  ContentView.swift
//  PunkBeer
//
//  Created by Nikita Sarin on 14.10.2023.
//

import SwiftUI

struct ContentView: View {

    var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            if let beers = viewModel.beers {
                ScrollView {
                    LazyVStack {
                        ForEach(beers) { beer in
                            BeerRow(
                                beer: beer,
                                fetcher: viewModel.service
                            )
                            .padding(.vertical)
                            .background(Color(uiColor: .systemBackground))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }
                .background(Color(uiColor: .systemGroupedBackground))
                .navigationTitle("Punk App")
            } else {
                ProgressView()
            }
        }
        .task {
            await viewModel.onAppear()
        }
    }
}

#Preview {
    ContentView(viewModel: .init(service: NetworkMock()))
}
