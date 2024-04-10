//
//  Ingredient.swift
//  CookEase
//
//  Created by Luana Kimley on 28/02/2024.
//

import Foundation
import SwiftData

enum MeasurementUnit: String, Codable {
    case grams
    case milliliters
    case tablespoons
    case teaspoons
    case pieces
}

@Model
class Ingredient: Codable, Hashable {
    enum CodingKeys: CodingKey {
        case name
        case calories
        case measurementUnit
    }
    
    var name: String
    var calories: Double // Calories per 100 grams, 100 milliliters, or per piece/tablespoon/teaspoon
    var measurementUnit: MeasurementUnit
    
    
    init(name: String, calories: Double, measurementUnit: MeasurementUnit) {
        self.name = name
        self.calories = calories
        self.measurementUnit = measurementUnit
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        calories = try container.decode(Double.self, forKey: .calories)
        measurementUnit = try container.decode(MeasurementUnit.self, forKey: .measurementUnit)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(calories, forKey: .calories)
        try container.encode(measurementUnit, forKey: .measurementUnit)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(calories)
        hasher.combine(measurementUnit)
    }
    
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.name == rhs.name && lhs.calories == rhs.calories && lhs.measurementUnit == rhs.measurementUnit
    }
}
