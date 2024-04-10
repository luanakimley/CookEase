//
//  User.swift
//  CookEase
//
//  Created by Luana Kimley on 28/02/2024.
//

import Foundation
import SwiftData

@Model
class User : Codable {
    enum CodingKeys: CodingKey {
        case firstName
        case surname
        case email
        case password
        case postedRecipes
        case favouriteRecipes
    }
    
    var firstName : String
    var surname : String
    @Attribute(.unique) var email : String
    var password : String
    
    @Relationship(deleteRule: .cascade, inverse: \Recipe.postedBy)
    var postedRecipes: [Recipe] = []
    
    @Relationship(inverse: \Recipe.favouritedBy)
    var favouriteRecipes: [Recipe] = []
    
    init(firstName: String = "", surname: String = "", email: String = "", password: String = "") {
        self.firstName = firstName
        self.surname = surname
        self.email = email
        self.password = password
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstName = try container.decode(String.self, forKey: .firstName)
        surname = try container.decode(String.self, forKey: .surname)
        email = try container.decode(String.self, forKey: .email)
        password = try container.decode(String.self, forKey: .password)
        postedRecipes = try container.decode([Recipe].self, forKey: .postedRecipes)
        favouriteRecipes = try container.decode([Recipe].self, forKey: .favouriteRecipes)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(surname, forKey: .surname)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(postedRecipes, forKey: .postedRecipes)
        try container.encode(favouriteRecipes, forKey: .favouriteRecipes)
    }
}
