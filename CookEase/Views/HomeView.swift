//
//  HomeView.swift
//  CookEase
//
//  Created by Luana Kimley on 28/02/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var favourites: [Recipe]
    @Query private var breakfast: [Recipe]
    @Query private var lunch: [Recipe]
    @Query private var dinner: [Recipe]
    
    func recipeCard(recipe: Recipe) -> some View {
        VStack {
          Text(recipe.name)
        }
        .frame(height: 200)
        .background(Color(UIColor.systemPink).opacity(0.95))
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
                    HStack {
                        ForEach(favourites) {
                            recipe in recipeCard(recipe: recipe)
                        }
                    }
                    .frame(minHeight: 0, maxHeight: .greatestFiniteMagnitude)
                }
                .frame(height: 100)
                .transition(.move(edge: .bottom))
    }
}

#Preview {
    HomeView()
}
