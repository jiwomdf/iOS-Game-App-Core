//
//  File.swift
//  
//
//  Created by koinworks on 31/10/23.
//

import Foundation

public struct GameResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
      case count = "count"
      case next = "next"
      case results = "results"
    }
    
    let count: CLong?
    let next: String?
    let results: [GameItemResponse]
}

public struct GameItemResponse: Decodable {

    private enum CodingKeys: String, CodingKey {
      case id = "id"
      case name = "name"
      case released = "released"
      case backgroundImage = "background_image"
      case rating = "rating"
    }

    let id: Int?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
}
