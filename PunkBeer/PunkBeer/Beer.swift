//
//  Beer.swift
//  PunkBeer
//
//  Created by Nikita Sarin on 14.10.2023.
//

import Foundation

struct Beer: Codable, Identifiable {
    let id: Int64
    let name: String
    let description: String
    let imageUrl: URL?
    let abv: Double?
    let ibu: Double?
}

extension Beer {

    static let mock = Beer(
        id: 1,
        name: "Lager",
        description: "Descrition",
        imageUrl: URL(string: "https://example.com"),
        abv: 1,
        ibu: 1
    )

    static let mock2 = Beer(
        id: 2,
        name: "Wise",
        description: "Descrition",
        imageUrl:  URL(string: ""),
        abv: 1,
        ibu: 1
    )
}
