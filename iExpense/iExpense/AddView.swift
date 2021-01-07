//
//  AddView.swift
//  iExpense
//
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var cost = ""
    let type = ["Business","Personal"]
    @State private var typeSelector = 0
    @ObservedObject var expenses:Expenses
    @State private var showingAlert = false
    
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray, width: 3)
                TextField("Cost", text: $cost)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .border(Color.gray, width: 3)
                    .keyboardType(.decimalPad)
                
                Picker("Choose type", selection: $typeSelector) {
                    ForEach(0..<type.count){
                        Text("\(type[$0])")
                    }
                }
            }
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text("Error"), message: Text("type numbers not letters!"), dismissButton: .default(Text("OK")))
            })
            .navigationBarTitle("Add expense")
            .navigationBarItems(trailing: Button(action: {
                if let actualAmount = Int(cost){
                    let item = ExpenseItem(name: name, type: type[typeSelector], cost: actualAmount)
                    expenses.myExpenses.append(item)
                }
                else {
                    showingAlert = true
                }
                presentationMode.wrappedValue.dismiss()
                
            }, label: {
                Text("Save")
            }))
            
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
