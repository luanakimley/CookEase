//
//  File.swift
//  CookEase
//
//  Created by Luana Kimley on 28/02/2024.
//

import Foundation
import SwiftData

@Model
class MealPlan {
    var breakfast : Recipe?
    var lunch : Recipe?
    var dinner : Recipe?
    
    init(breakfast: Recipe? = nil, lunch: Recipe? = nil, dinner: Recipe? = nil) {
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
    }
}
