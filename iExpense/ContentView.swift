//
//  ContentView.swift
//  iExpense
//
//  Created by Arno Delalieux on 24/02/2025.
//

import SwiftUI

@Observable class User {
    var firstName = "Balbo"
    var lastName = "Baggins"
}

struct ContentView: View {
    @State private var user = User()
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("Your first name", text: $user.firstName)
            TextField("Your last name", text: $user.lastName)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
