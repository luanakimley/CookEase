//
//  SignInView.swift
//  CookEase
//
//  Created by Luana Kimley on 28/02/2024.
//

import SwiftUI
import SwiftData

struct SignInView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.modelContext) var modelContext
    
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    
    @Query private var users: [User]
    
    @AppStorage("loggedInUser") private var loggedInUser: String = ""
        
    var body: some View {
        NavigationStack {
            let backgroundColour: Color = colorScheme == .dark ? .black : .white
            VStack {
                // Header
                HeaderView()
                
                // Login Form
                ZStack {
                    RoundedRectangle(cornerRadius: 25.0).foregroundColor(backgroundColour)
                        .padding(0)
                    
                    VStack {
                        Text("Sign In").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding(.top, 35)
                        
                        Form {
                            TextField("Email Address", text: $email).autocapitalization(.none)
                            SecureField("Password", text: $password)
                            
                            Button(action: {
                                logIn()
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.blue)
                                        .frame(height: 44)
                                    Text("Log In").bold().foregroundColor(Color.white)
                                }
                            }.padding(.top, 10)
                        }.scrollContentBackground(.hidden)
                            .navigationDestination(isPresented: $isLoggedIn, destination: { CookEaseTabView().navigationBarBackButtonHidden(true)
                        })
                        
                        VStack {
                            Text("Don't have an account?")
                            NavigationLink("Create account here", destination: CreateAccountView()).foregroundColor(Color.blue)
                        }.padding(.bottom, 30)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                }.padding(20)
                
            }.background(Color.yellow)
            .ignoresSafeArea(.keyboard)
        }
    }
    
    func logIn() {
        if let user = users.first(where: { $0.email == email && $0.password == password }) {
            print("Login successful")
            let encoder = JSONEncoder()
            do {
                let encodedLoggedInUser = try encoder.encode(user)
                loggedInUser = String(data: encodedLoggedInUser, encoding: .utf8) ?? ""
                print(loggedInUser)
                isLoggedIn = true
    
              } catch {
                print("Error encoding user")
              }
          } else {
            print("Invalid email or password")
          }
    }
}

#Preview {
    SignInView()
}
