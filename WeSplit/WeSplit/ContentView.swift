//
//  ContentView.swift
//  WeSplit
//
//

import SwiftUI

struct ContentView: View {
    @State private var chequeAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 0
    let tips = [0,10,15,20,25]
    
    var totalPerPerson: Double{
        let amount1 = Double(chequeAmount) ?? 0
        var amount2: Double = 0
        if amount1 > 0 {
            amount2 = amount1 * Double(tips[tipPercentage]) / 100 + amount1
        }
        return numberOfPeople > 0 ? amount2 / Double(numberOfPeople + 1
            ): amount2
    }
    var body: some View {
        NavigationView{
            Form{
                Section(header:Text("Bill")){
                    TextField("Enter cheque amount", text: $chequeAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(1..<100){
                            Text("\($0)")
                        }
                    }
                }
                Section(header: Text("Tip Amount")){
                    Picker("Tip %", selection: $tipPercentage) {
                        ForEach(0..<tips.count){
                            Text("\(tips[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header:Text("Total with tip")){
                    let amount1 = Double(chequeAmount) ?? 0
                    Text("$\(amount1 * Double(tips[tipPercentage]) / 100 + amount1, specifier: "%.2f")")
                        .foregroundColor(tipPercentage == 0 ? .red : .none)
                }
                
                Section(header:Text("Amount per person")){
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                
            }.navigationBarTitle(Text("SpliT iT"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
