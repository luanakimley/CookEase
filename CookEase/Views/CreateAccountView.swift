//
//  CreateAccountView.swift
//  CookEase
//
//  Created by Luana Kimley on 28/02/2024.
//

import SwiftUI
import SwiftData

struct CreateAccountView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.colorScheme) private var colorScheme
    
    @State private var firstName = ""
    @State private var surname = ""
    @State private var email = ""
    @State private var password = ""
    
    @State private var isCreated = false
    
    var body: some View {  
    let backgroundColour: Color = colorScheme == .dark ? .black : .white
        VStack {
            // Header
            HeaderView()
     
            // Login Form
            ZStack {
                RoundedRectangle(cornerRadius: 25.0).foregroundColor(backgroundColour)
                    .padding(0)
                
                VStack {
                    Text("Create Account").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).padding(.top, 35)
                    
                    Form {
                        TextField("First name", text: $firstName)
                        TextField("Surname", text: $surname)
                        TextField("Email Address", text: $email).autocapitalization(.none)
                        SecureField("Password", text: $password)
                        
                        Button(action: {
                            createAccount()
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.blue)
                                    .frame(height: 44)
                                Text("Create Account").bold().foregroundColor(Color.white)
                            }
                        }.padding(.top, 10)
                    }.scrollContentBackground(.hidden).navigationDestination(isPresented: $isCreated,  destination: { SignInView() })
                    
                    VStack {
                        Text("Already have an account?")
                        NavigationLink("Sign in here", destination: SignInView()).foregroundColor(Color.blue)
                    }.padding(.bottom, 30)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            }.padding(20)
            
        }.background(Color.yellow)
        .ignoresSafeArea(.keyboard)
    }
    
    private func createAccount() {
        let newUser = User(firstName: firstName, surname: surname, email: email, password: password)
        modelContext.insert(newUser)
        isCreated = true
    }
}

#Preview {
    CreateAccountView()
}
