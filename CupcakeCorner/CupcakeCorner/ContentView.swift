//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Vahagn Martirosyan on 2021-01-12.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select Type", selection: $order.cakeType){
                        ForEach(0..<Order.types.count){ type in
                            Text(Order.types[type])
                        }
                    }
                    
                    Stepper(value: $order.cakeQty, in: 3...20){
                        Text("Number of cakes: \(order.cakeQty)")
                    }
                }
                
                Section{
                    Toggle("Special Request ", isOn: $order.specialRequest.animation())
                    
                    if order.specialRequest{
                    Toggle("Extra Frostings ", isOn: $order.extraFrosting)
                    Toggle("Extra Sprinkles", isOn: $order.extraSprinkles)
                    }
                }
                
                Section{
                    NavigationLink("Delivery Details", destination: AddressView(order: order))
                }
            }
            .navigationBarTitle(Text("CupCake"))
        }
    }
    
   
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




