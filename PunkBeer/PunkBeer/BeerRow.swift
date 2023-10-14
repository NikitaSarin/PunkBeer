//
//  BeerRow.swift
//  PunkBeer
//
//  Created by Nikita Sarin on 14.10.2023.
//

import SwiftUI

struct BeerRow: View {

    enum Specs {
        static let edge = 80.0
    }

    let beer: Beer
    let fetcher: ImageFetching

    var body: some View {
        HStack {
            LoadableImage(
                url: beer.imageUrl,
                fetcher: fetcher
            )
            .frame(width: Specs.edge, height: Specs.edge)
            .cornerRadius(12)
            VStack {
                HStack {
                    Text(beer.name)
                        .font(.system(size: 16, weight: .bold))
                        .lineLimit(1)
                    Spacer()
                }
                HStack {
                    Text(beer.description)
                        .lineLimit(3)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    BeerRow(beer: .mock, fetcher: NetworkMock())
}
