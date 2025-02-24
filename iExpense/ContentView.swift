//
//  ContentView.swift
//  iExpense
//
//  Created by Arno Delalieux on 24/02/2025.
//

import SwiftUI
import Observation

@Observable class User {
    var firstName = "Balbo"
    var lastName = "Baggins"
}

struct SecondView: View {
    var body: some View {
        Text("Second View")
    }
}

struct ContentView: View {
    @State private var user = User()
    var body: some View {
        VStack {
            Section {
                Text("Your name is \(user.firstName) \(user.lastName)")
                
                TextField("Your first name", text: $user.firstName)
                TextField("Your last name", text: $user.lastName)
            }
            Section {
                Button("Show sheet") {
                    // show sheet
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
