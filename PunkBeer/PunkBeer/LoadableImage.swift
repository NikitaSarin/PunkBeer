//
//  LoadableImage.swift
//  PunkBeer
//
//  Created by Nikita Sarin on 14.10.2023.
//

import SwiftUI

struct LoadableImage: View {

    private let url: URL?
    private let fetcher: ImageFetching

    @State var image: UIImage?

    init(
        url: URL?,
        fetcher: ImageFetching
    ) {
        self.url = url
        self.fetcher = fetcher
    }

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if let url = url {
                ProgressView()
                    .task {
                        image = try? await fetcher.fetchImage(url: url)
                    }
            } else {
                Color
                    .gray
                    .opacity(0.2)
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(12)
            }
        }
    }
}

#Preview {
    LoadableImage(
        url: URL(string: ""),
        fetcher: NetworkMock()
    )
    .frame(width: 100)
}
