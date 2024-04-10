//
//  CreateRecipeView.swift
//  CookEase
//
//  Created by Luana Kimley on 28/02/2024.
//

import SwiftUI
import PhotosUI
import SwiftData

struct CreateRecipeView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var ingredients: [Ingredient]
    
    @State private var recipe = Recipe()
    
    @State private var selectedIngredients: [Ingredient] = []
    @State private var ingredientQuantity: [Int] = []
    
    @State private var presentIngredientsSheet: Bool = false
    @State private var searchQuery: String = ""
    
    @State private var presentAddInstructionSheet: Bool = false
    
    @State private var addedInstruction: Instruction = Instruction()
    @State private var addedInstructions: [Instruction] = []
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    func toggleIngredientSheet() {
        self.presentIngredientsSheet = !presentIngredientsSheet
    }
    
    func toggleAddInstructionSheet() {
        self.presentAddInstructionSheet = !presentAddInstructionSheet
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Create Recipe").bold().font(.title).padding(.top, 10)
                List {
                    Section(header: Text("")) {
                        TextField("Name", text: $recipe.name)
                    }
                    
                    Section(header: Text("Ingredients")) {
                        Button(action: toggleIngredientSheet) {
                            Text("Choose Ingredients").foregroundColor(Color.blue)
                        }
                        
                        ForEach(selectedIngredients.indices, id: \.self) { index in
                            HStack {
                                Text(selectedIngredients[index].name).bold()
                                Spacer()
                                TextField("", text: Binding(
                                    get: {
                                        String(ingredientQuantity[index])
                                    },
                                    set: { newValue in
                                        if let quantity = Int(newValue) {
                                            ingredientQuantity[index] = quantity
                                        }
                                    }
                                )).frame(width: 40)
                                Text(selectedIngredients[index].measurementUnit.rawValue)
                            }
                        }.onDelete(perform: { indexSet in
                            selectedIngredients.remove(atOffsets: indexSet)
                            ingredientQuantity.remove(atOffsets: indexSet)
                        })
                    }.sheet(isPresented: $presentIngredientsSheet, content: {
                        NavigationStack {
                            Text("Calories is per piece or per 100 gr/ml")
                            List(allIngredients) {
                                ingredient in HStack {
                                    Text(ingredient.name).bold()
                                    Text("|")
                                    Text(String(Int(ingredient.calories)) + " calories")
                                    Spacer()
                                    Button(action: { addOrRemoveToSelectedIngredients(newIngredient: ingredient)}) {
                                        if !selectedIngredients.contains(ingredient) {
                                            Image(systemName: "plus").foregroundColor(Color.blue)
                                        } else {
                                            Image(systemName: "minus").foregroundColor(Color.blue)
                                        }
                                    }
                                }
                            }
                            
                        }
                        .presentationDetents([.medium, .large])
                        .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search Ingredient")
                    })
                    
                    Section(header: Text("Instructions")) {
                        Button(action: toggleAddInstructionSheet) {
                            Text("Add Instruction").foregroundColor(Color.blue)
                        }
                        
                        ForEach(addedInstructions.indices, id: \.self) { index in
                            HStack {
                                Text(addedInstructions[index].action).bold()
                                Spacer()
                            }
                        }.onDelete(perform: { indexSet in
                            addedInstructions.remove(atOffsets: indexSet)
                        })
                    }.sheet(isPresented: $presentAddInstructionSheet, content: {
                        NavigationStack {
                            Form {
                                TextField("Action", text: $addedInstruction.action, axis: .vertical)
                                HStack {
                                    Text("Time taken")
                                    Spacer()
                                    TextField("", value: $addedInstruction.minutesTaken, format: .number).frame(width: 30)
                                    Text("minutes")
                                }
                                
                                PhotosPicker(
                                    selection: $selectedItem,
                                    matching: .images,
                                    photoLibrary: .shared()
                                ) {
                                    Text("Select a photo")
                                }
                                .foregroundColor(Color.blue)
                                .onChange(of: selectedItem) {
                                    Task {
                                        if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                                            selectedImageData = data
                                        }
                                    }
                                }
                                
                                if let selectedImageData = selectedImageData,
                                   let uiImage = UIImage(data: selectedImageData) {
                                    
                                    VStack(alignment: HorizontalAlignment.center) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 250, height: 250)
                                    }
                                    
                                    Button("Remove Image") {
                                        selectedItem = nil
                                        self.selectedImageData = nil
                                    }.foregroundColor(Color.blue)
                                    
                                }
                                
                                Button(action: {
                                    addInstruction(newInstruction: addedInstruction)
                                }) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color.yellow)
                                            .frame(height: 44)
                                        Text("Add Instruction").bold().foregroundColor(Color.black)
                                    }
                                }
                                
                            }
                            
                        }
                        .presentationDetents([.medium, .large])
                    })
                    
                    Button(action: {
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.blue)
                                .frame(height: 44)
                            Text("Create Recipe").bold().foregroundColor(Color.white)
                            }
                        }.padding(.top, 10)
                }
            }
        }
    }
    
    private var allIngredients : [Ingredient] {
        if searchQuery.isEmpty {
            return ingredients
        } else {
            return ingredients.filter {
                $0.name.contains(searchQuery)
            }
        }
    }
    
    private func addOrRemoveToSelectedIngredients(newIngredient: Ingredient) {
        if !selectedIngredients.contains(newIngredient) {
            selectedIngredients.append(newIngredient)
            ingredientQuantity.append(0)
            print(ingredientQuantity)
            print(selectedIngredients)
        } else {
            if let index = selectedIngredients.firstIndex(of: newIngredient) {
                selectedIngredients.remove(at: index)
                ingredientQuantity.remove(at: index)
                print(selectedIngredients)
            }
        }
    }
    
    private func addInstruction(newInstruction: Instruction) {
        addedInstructions.append(newInstruction)
        print(addedInstructions[0].action)
    }
}

#Preview {
    CreateRecipeView().modelContainer(for: Ingredient.self)
}

