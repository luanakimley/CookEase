//
//  CookEaseTabView.swift
//  CookEase
//
//  Created by Luana Kimley on 28/02/2024.
//

import SwiftUI

struct CookEaseTabView: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            CreateRecipeView().tabItem {
                Image(systemName: "fork.knife.circle")
                Text("Create Recipe")
            }
            
            FavouritesView().tabItem {
                Image(systemName: "star")
                Text("Favourites")
            }
        }
    }
}

#Preview {
    CookEaseTabView()
}
