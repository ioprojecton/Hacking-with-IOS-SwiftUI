//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Vahagn Martirosyan on 2021-01-14.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order:Order
    
    var body: some View {
        Form{
            Section{
                TextField("Enter Name", text: $order.name)
                TextField("Enter Address", text: $order.address)
                TextField("City", text: $order.city)
                TextField("ZipCode",text: $order.zip)
            }
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(!order.hasValidAddress)
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
