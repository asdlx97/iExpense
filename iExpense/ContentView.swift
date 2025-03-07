//
//  ContentView.swift
//  iExpense
//
//  Created by Arno Delalieux on 24/02/2025.
//

import SwiftUI
import Observation



struct FirstView: View {
    @State private var user = User()
    @Observable class User {
        var firstName = "Balbo"
        var lastName = "Baggins"
    }
    var body: some View {
        Section ("Using @State with classes and sharing State with @Observable"){
            Text("Your name is \(user.firstName) \(user.lastName)")
            
            TextField("Your first name", text: $user.firstName)
            TextField("Your last name", text: $user.lastName)
        }
        .padding()
    }
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
    // make the tapCount property read the value back from UserDefaults using same string key "Tap"
    //@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @AppStorage("tapCount") private var tapCount = 0 // This works exactly like @State but let's us ignore UserDefaults, here to we use a string key name to store the data, which can be anything and doesn't have to match the property name
    var body: some View {
        NavigationStack {
            VStack {
                Text("UserDefaultsView")
                
                Button("Tap count: \(tapCount)") {
                    tapCount += 1
                    // .standard is the build-in instance for UserDefault
                    // The single set() method accepts any kind of data
                    // Case-sensitive string "tap" to name our data
                    //UserDefaults.standard.set(tapCount, forKey: "Tap") When using the @AppStorage property wrapper this line isn't needed anymore
                }
                
                Button("Dismiss") {
                    dismiss()
            }
        }
        
        }
    }
}

struct ArchiveWithCodableView: View {
    
    struct User: Codable {
        var firstName: String
        var lastName: String
    }
    
    @State private var user = User(firstName: "Arno", lastName: "Delalieux")
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Archiving with Codable")
                    .font(.title)
                Text("This is \(user.firstName)")
                TextField("Your first name", text: $user.firstName)

                Button("Save User") {
                    let encoder = JSONEncoder()
                    
                    if let data = try? encoder.encode(user) {
                        UserDefaults.standard.set(data, forKey: "UserData")
                    }
                }
            }
        }
        
    }
}

struct LearningView: View {
    //boolean to track state wheter sheet is showing
    @State private var showingFirstSheet = false
    @State private var showingSecondSheet = false
    @State private var showLearningSheet = false
    @State private var showUserDefaultsSheet = false
    @State private var showArchiveWithCodableSheet = false
    var body: some View {
        
        VStack {
            Text("What to know to make this App")
                .font(.title)
            
            Section ("Using @State with classes and sharing State with @Observable") {
                Button("Show sheet") {
                    showingFirstSheet.toggle()
                }
                .sheet(isPresented: $showingFirstSheet) {
                    //contents of the sheet
                    FirstView()
                }
                
            }
            .padding()
            
            Section ("Showing and hiding views") {
                Button("Show sheet") {
                    showingSecondSheet.toggle()
                }
                .sheet(isPresented: $showingSecondSheet) {
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
            Section("Archive with Codable") {
                Button("Show ArchiveWithCodable sheet") {
                    showArchiveWithCodableSheet.toggle()
                }
                .sheet(isPresented: $showArchiveWithCodableSheet) {
                    ArchiveWithCodableView()
                }
            }
            .padding()
            
        }
        .padding()
    }
        
    }


struct ContentView: View {
    @State var showLearningView = false
    // create an instance of our Expenses() class
    @State private var expenses = Expenses()
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationStack {
            List {
                // tells the `ForEach` to identify each expense item uniquely by its name, then prints the name out as the list row.
                ForEach(expenses.items, id:\.id) { item in
                    Text (item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    let expense = ExpenseItem(name: "Test", type: "personal", amount: 5)
                    expenses.items.append(expense)
                }
            }
            
        }
        
        Section("What to know for this App") {
            Button("Check what we learned") {
                showLearningView.toggle()
            }
            .sheet(isPresented: $showLearningView) {
                LearningView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
