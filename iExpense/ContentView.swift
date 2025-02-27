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
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("Second View")
            .font(.title)
        Text("Hello, \(name) welcome to this new sheet!")
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct OnDeleteView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @Environment(\.dismiss) var dismiss
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }

    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add number") {
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
                Button("Dismiss") {
                    dismiss()
                }
            }
            .toolbar {
                EditButton()
        }
        
        }
    }
}

struct UserDefaultsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var tapCount = 0
    var body: some View {
        NavigationStack {
            VStack {
                Text("UserDefaultsView")
                
                Button("Tap count: \(tapCount)") {
                    tapCount += 1
                }
                
                Button("Dismiss") {
                    dismiss()
            }
        }
        
        }
    }
}

struct ContentView: View {
    @State private var user = User()
    //boolean to track state wheter sheet is showing
    @State private var showingSheet = false
    @State private var showLearningSheet = false
    @State private var showUserDefaultsSheet = false
    var body: some View {
        VStack {
            Section ("Using @State with classes and sharing State with @Observable"){
                Text("Your name is \(user.firstName) \(user.lastName)")
                
                TextField("Your first name", text: $user.firstName)
                TextField("Your last name", text: $user.lastName)
            }
            .padding()
            Section ("Showing and hiding views") {
                Button("Show sheet") {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    //contents of the sheet
                    SecondView(name: "Arno")
                }
                
            }
            .padding()
            Section ("Deleting items using onDelete()") {
                Button("Show learning sheet") {
                    showLearningSheet.toggle()
                }
                .sheet(isPresented: $showLearningSheet) {
                    OnDeleteView()
                }
            }
            .padding()
            Section("Storing user settings with userDefaults") {
                Button("Show userDefaults sheet") {
                    showUserDefaultsSheet.toggle()
                }
                .sheet(isPresented: $showUserDefaultsSheet) {
                    UserDefaultsView()
                }
            }
            .padding()
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
