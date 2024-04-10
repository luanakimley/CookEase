//
//  CookEaseApp.swift
//  CookEase
//
//  Created by Luana Kimley on 28/02/2024.
//

import SwiftUI
import SwiftData

@main
@MainActor
struct CookEaseApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Ingredient.self,
            Instruction.self,
            Recipe.self,
            MealPlan.self,
            User.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            
            // https://www.andrewcbancroft.com/blog/ios-development/data-persistence/pre-populate-swiftdata-persistent-store/
            var ingredientFetchDescriptor = FetchDescriptor<Ingredient>()
            ingredientFetchDescriptor.fetchLimit = 1
            
            guard try container.mainContext.fetch(ingredientFetchDescriptor).count == 0 else {
                return container
            }
            
            guard let fileURL = Bundle.main.url(forResource: "ingredients", withExtension: "json") else {
                return container
            }
            
            let jsonData = try Data(contentsOf: fileURL)
                    
            let ingredients = try JSONDecoder().decode([Ingredient].self, from: jsonData)
            
            for ingredient in ingredients {
                container.mainContext.insert(ingredient)
            }

            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            LandingView()
        }
        .modelContainer(sharedModelContainer)
    }
}
