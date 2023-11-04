//
//  File.swift
//  
//
//  Created by koinworks on 01/11/23.
//

import Foundation
import RealmSwift

public class GameDetailEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var descriptions: String = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var released: String = ""
    @objc dynamic var esrbRating: String = ""
    @objc dynamic var backgroundImage: String = ""
    
    public override static func primaryKey() -> String? {
      return "id"
    }
    
    public override init() {}
    
    init(
        id: Int,
        name: String,
        descriptions: String,
        rating: Double,
        released: String,
        esrbRating: String,
        backgroundImage: String
    ) {
        self.id = id
        self.name = name
        self.descriptions = descriptions
        self.rating = rating
        self.released = released
        self.esrbRating = esrbRating
        self.backgroundImage = backgroundImage
    }
    
}
