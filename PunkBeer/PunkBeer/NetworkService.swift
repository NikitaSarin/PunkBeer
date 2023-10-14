//
//  NetworkService.swift
//  PunkBeer
//
//  Created by Nikita Sarin on 14.10.2023.
//

import Foundation
import UIKit

protocol Networking {
    func loadBeers() async throws -> [Beer]
}

protocol ImageFetching {
    func fetchImage(url: URL) async throws -> UIImage
}

actor NetworkService {

    enum Error: Swift.Error {
        case corruptedImage
    }

    private let baseURL = "https://api.punkapi.com/v2/"
    private let session = URLSession.shared
    private var cache = [URL: UIImage]()
}

extension NetworkService: Networking {

    func loadBeers() async throws -> [Beer] {
        let url = URL(string: baseURL + "beers")!
        let (data, _) = try await session.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let beers = try decoder.decode([Beer].self, from: data)
        return beers
    }
}

extension NetworkService: ImageFetching {

    func fetchImage(url: URL) async throws -> UIImage {
        if let image = cache[url] {
            return image
        }
        let (data, _) = try await session.data(from: url)
        guard
            let image = UIImage(data: data)
        else { throw Error.corruptedImage }
        cache[url] = image
        return image
    }
}

struct NetworkMock: Networking, ImageFetching {

    func loadBeers() async throws -> [Beer] {
        [.mock, .mock2]
    }

    func fetchImage(url: URL) async throws -> UIImage {
        return UIImage(named: "ipa") ?? UIImage()
    }
}
