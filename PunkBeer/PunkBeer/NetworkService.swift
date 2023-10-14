//
//  NetworkService.swift
//  PunkBeer
//
//  Created by Nikita Sarin on 14.10.2023.
//

import Foundation


struct Beer: Codable, Identifiable {
    let id: Int64
    let name: String
    let description: String
    let imageUrl: String
    let abv: Double?
    let ibu: Double?
}

protocol Networking {
    func loadBeers() async throws -> [Beer]
}

final class NetworkService {

    let baseURL = "https://api.punkapi.com/v2/"
    let session = URLSession.shared
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

struct NetworkMock: Networking {
    func loadBeers() async throws -> [Beer] {
        [
            Beer(
                id: 1,
                name: "Lager",
                description: "Descrition kwedjvberwkjqbfkejwqrbgk;jeqwr hgkjerhglejkrwhglkeqrwhglekrwhjg lrekwjgrelkjgre;lgj;rewljkger;lkg;erwlkgr;ewlkg;erlqjg",
                imageUrl: "",
                abv: 1,
                ibu: 1
            ),
            Beer(
                id: 2,
                name: "Wise",
                description: "Descrition",
                imageUrl: "",
                abv: 1,
                ibu: 1
            )
        ]
    }
}
