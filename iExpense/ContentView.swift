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
    let name: String
    
    var body: some View {
        Text("Second View")
            .font(.title)
        Text("Hello, \(name) welcome to this new sheet!")
    }
}

struct ContentView: View {
    @State private var user = User()
    //boolean to track state wheter sheet is showing
    @State private var showingSheet = false
    var body: some View {
        VStack {
            Section {
                Text("Your name is \(user.firstName) \(user.lastName)")
                
                TextField("Your first name", text: $user.firstName)
                TextField("Your last name", text: $user.lastName)
            }
            Section {
                Button("Show sheet") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    //contents of the sheet
                    SecondView(name: "Arno")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
