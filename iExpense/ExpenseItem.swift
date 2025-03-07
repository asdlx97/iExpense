//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Arno Delalieux on 06/03/2025.
//

import SwiftUI

// a struct to represent a single item of expense
struct ExpenseItem {
    //let id: UUID() //this would mean we have to generate an UUID by hand
    let id = UUID() //this generates the UUID automatically, watch the equal sign
    let name: String
    let type: String
    let amount: Double
}

// class to store an array of those expense items inside a single object
@Observable class Expenses {
    var items = [ExpenseItem]()
}
