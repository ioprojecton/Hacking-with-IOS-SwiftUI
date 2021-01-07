//
//  ContentView.swift
//  iExpense
//
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var mirror = Expenses()
    @State private var showingExpensesView = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(mirror.myExpenses) {item in
                    
                    HStack {
                        VStack(alignment:.leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.cost)")
                            .foregroundColor(item.cost < 10 ? .blue : item.cost < 100 ? .black : .green)
                    }
                    
                }.onDelete(perform: { indexSet in
                    delete(item: indexSet)
                })
            }
            .navigationBarItems(leading: EditButton(),trailing: Button(action: {
                showingExpensesView = true
            }, label: {
                Image(systemName: "plus")
            }))
            .navigationBarTitle(Text("iExpense"))
            .sheet(isPresented: $showingExpensesView, content: {
                AddView(expenses: mirror)
            })
        }
    }
    
    
    func delete(item:IndexSet){
        mirror.myExpenses.remove(atOffsets: item)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class Expenses: ObservableObject {
    @Published var myExpenses = [ExpenseItem](){
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(myExpenses){
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: savedItems){
                myExpenses = decoded
                return
            }
        }
        myExpenses = []
    }
    
    
    
}


