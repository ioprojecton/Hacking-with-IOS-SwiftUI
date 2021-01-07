//
//  ExpenseItem.swift
//  iExpense
//
//

import Foundation

struct ExpenseItem: Identifiable,Codable{
    var id = UUID()
    var name: String
    var type: String
    var cost: Int
    
}
