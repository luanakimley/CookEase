//
//  Recipe.swift
//  CookEase
//
//  Created by Luana Kimley on 28/02/2024.
//

import Foundation
import SwiftData

@Model
class Recipe : Codable {
    enum CodingKeys: CodingKey {
        case name
        case ingredients
        case instructions
        case postedBy
        case favouritedBy
    }
    
    @Attribute(.unique) var name : String
    var ingredients: [Ingredient: Int] = [:]
    var instructions : [Instruction] = []
    
    var postedBy: User
    var favouritedBy: [User] = []
    
    init() {
        self.name = ""
        self.ingredients = [:]
        self.instructions = []
        self.postedBy = User()
    }
    
    init(name: String, ingredients: [Ingredient: Int], instructions: [Instruction], postedBy: User) {
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
        self.postedBy = postedBy
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        ingredients = try container.decode([Ingredient : Int].self, forKey: .ingredients)
        instructions = try container.decode([Instruction].self, forKey: .instructions)
        postedBy = try container.decode(User.self, forKey: .postedBy)
        favouritedBy = try container.decode([User].self, forKey: .favouritedBy)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(instructions, forKey: .instructions)
        try container.encode(postedBy, forKey: .postedBy)
        try container.encode(favouritedBy, forKey: .favouritedBy)
    }
}
