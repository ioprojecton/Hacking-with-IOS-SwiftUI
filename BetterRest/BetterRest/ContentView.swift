//
//  ContentView.swift
//  BetterRest
//
//  Created by Vahagn Martirosyan on 2021-01-01.
//

import SwiftUI

struct ContentView: View {
    static var defaultWakeupTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    @State private var myWakeUpTime = defaultWakeupTime
    @State private var myDesiredSleepAmount = 8.0
    @State private var myConsumedCoffees = 3
    @State private var alertTitle = ""
    @State private var alertTitleBody = ""
    @State private var alertActive = false
    
    var body: some View {
        NavigationView{
            Form{
                Section(header:Text("When do you want to wake up ?")){
                    DatePicker("Date", selection: $myWakeUpTime, in: Date()..., displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                Section(header: Text("Desired amount of sleep")) {
                    
                    Stepper("enter something", value: $myDesiredSleepAmount, in: 4...12, step: 0.25)
                        .labelsHidden()
                    
                    Text("\(myDesiredSleepAmount,specifier: "%.2g") hrs")
                }
                
                Section(header:Text("Daily Coffee intake")){
                    
                    Picker("How many cups?", selection: $myConsumedCoffees){
                        ForEach(1..<20){ coffee in
                            Text(coffee > 1 ? "\(coffee) Cups" :
                                    "\(coffee) Cup")
                        }
                    }
                }
                HStack{
                    Spacer()
                    Text("BedTime is")
                        .font(.headline)
                    Text("\(bestTime)")
                        .foregroundColor(.green)
                    
                    Spacer()
                }
            }
            .alert(isPresented: $alertActive, content: {
                Alert(title: Text(alertTitle), message: Text(alertTitleBody), dismissButton: .default(Text("OK")))
            })
            .navigationBarTitle(Text("BedTime Calculator"),displayMode: .inline)
            
        }
    }
    
    private var bestTime:String{
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour,.minute], from: myWakeUpTime)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: Double(myDesiredSleepAmount), coffee: Double(myConsumedCoffees))
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            return formatter.string(from: myWakeUpTime - prediction.actualSleep)
            
        } catch {
            alertTitle = "Error"
            alertTitleBody = "Something went wrong"
            alertActive = true
            return ""
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
