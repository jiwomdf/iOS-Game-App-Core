//
//  File.swift
//  
//
//  Created by koinworks on 31/10/23.
//

import Foundation

public struct GameDetailResponse: Decodable {
    
    private enum CodingKeys: String, CodingKey {
      case id = "id"
      case name = "name"
      case description = "description"
      case rating = "rating"
      case released = "released"
      case esrbRating = "esrb_rating"
      case metacriticPlatforms = "metacritic_platforms"
      case platforms = "platforms"
      case backgroundImage = "background_image"
    }
    
    let id: Int?
    let name: String?
    let description: String?
    let rating: Double?
    let released: String?
    let esrbRating: EsrbRatingResponse?
    let metacriticPlatforms: [MetricPlatformResponse]?
    let platforms: [PlatformsResponse]?
    let backgroundImage: String?
}

public struct EsrbRatingResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
      case name = "name"
    }
    
    let name: String?
}

public struct MetricPlatformResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
      case metascore = "metascore"
      case url = "url"
    }
    
    let metascore: Int?
    let url: String?
}

public struct PlatformsResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
      case platform = "platform"
    }
    
    let platform: PlatformResponse?
}

public struct PlatformResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
      case name = "name"
    }
    
    let name: String?
}
