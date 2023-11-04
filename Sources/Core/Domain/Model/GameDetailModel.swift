//
//  File.swift
//  
//
//  Created by koinworks on 31/10/23.
//

import Foundation

public struct GameDetailModel {
    public let id: Int
    public let name: String
    public let description: String
    public let rating: Double
    public let released: String
    public let esrbRating: String
    public let metacriticPlatforms: [MetricPlatformModel]?
    public let platforms: [PlatformModel]?
    public let bgImage: String
}

public struct MetricPlatformModel {
    public let metascore: Int
    public let url: String
}

public struct PlatformModel {
    public let name: String
}


func mapGameDetail(input response: GameDetailResponse) -> GameDetailModel {
    return GameDetailModel(
        id: response.id ?? 0,
        name: response.name ?? "",
        description: response.description ?? "",
        rating: response.rating ?? 0.0,
        released: response.released ?? "",
        esrbRating: response.esrbRating?.name ?? "",
        metacriticPlatforms: response.metacriticPlatforms?.map { result in
            MetricPlatformModel(
                metascore: result.metascore ?? 0,
                url: result.url ?? ""
            )
        },
        platforms: response.platforms?.map { result in
            return PlatformModel(
                name: result.platform?.name ?? ""
            )
        },
        bgImage: response.backgroundImage ?? ""
    )
}

func mapGameDetailEntity(input response: GameDetailResponse) -> GameDetailEntity {
    return GameDetailEntity(
        id: response.id ?? 0,
        name: response.name ?? "",
        descriptions: response.description ?? "",
        rating: response.rating ?? 0.0,
        released: response.released ?? "",
        esrbRating: response.esrbRating?.name ?? "",
        backgroundImage: response.backgroundImage ?? ""
    )
}


func mapGameDetail(entity: GameDetailEntity?) -> GameDetailModel? {
    guard entity != nil else { return nil }
    return GameDetailModel(
        id: entity?.id ?? 0,
        name: entity?.name ?? "",
        description: entity?.descriptions ?? "",
        rating: entity?.rating ?? 0.0,
        released: entity?.released ?? "",
        esrbRating: entity?.esrbRating ?? "",
        metacriticPlatforms: nil,
        platforms: nil,
        bgImage: entity?.backgroundImage ?? ""
    )
}
