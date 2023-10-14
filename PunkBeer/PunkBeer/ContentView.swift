//
//  ContentView.swift
//  PunkBeer
//
//  Created by Nikita Sarin on 14.10.2023.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationStack {
            if let beers = viewModel.beers {
                List(beers) { beer in
                    Section {
                        HStack {
                            RemoteImageView(
                                url: URL(string: beer.imageUrl)!,
                                placeholder: {
                                    ProgressView()
                                }, image: { image in
                                    image
                                        .aspectRatio(contentMode: .fit)
                                }
                            )
                            .frame(width: 60, height: 60)
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
                                        .lineLimit(2)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .navigationTitle("Punk App")
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                await viewModel.onAppear()
            }
        }
    }
}

#Preview {
    ContentView(viewModel: .init(service: NetworkMock()))
}

struct RemoteImageView<Placeholder: View, ConfiguredImage: View>: View {
    var url: URL
    private let placeholder: () -> Placeholder
    private let image: (Image) -> ConfiguredImage

    @ObservedObject var imageLoader: ImageLoaderService
    @State var imageData: UIImage?

    init(
        url: URL,
        @ViewBuilder placeholder: @escaping () -> Placeholder,
        @ViewBuilder image: @escaping (Image) -> ConfiguredImage
    ) {
        self.url = url
        self.placeholder = placeholder
        self.image = image
        self.imageLoader = ImageLoaderService(url: url)
    }

    @ViewBuilder private var imageContent: some View {
        if let data = imageData {
            image(Image(uiImage: data))
        } else {
            placeholder()
        }
    }

    var body: some View {
        imageContent
            .onReceive(imageLoader.$image) { imageData in
                self.imageData = imageData
            }
    }
}

class ImageLoaderService: ObservableObject {
    @Published var image = UIImage()

    convenience init(url: URL) {
        self.init()
        loadImage(for: url)
    }

    func loadImage(for url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data) ?? UIImage()
            }
        }
        task.resume()
    }
}
