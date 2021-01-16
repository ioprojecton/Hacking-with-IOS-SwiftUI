//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Vahagn Martirosyan on 2021-01-14.
//

import SwiftUI

struct CheckoutView: View {
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @ObservedObject var order:Order
    var body: some View {
        GeometryReader{geometry in
            ScrollView{
                VStack{
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                        
                    Text("Cost: \(order.cost, specifier: "%0.2f")")
                        .font(.title)
                    
                    Button(action: {
                        placeOrder()
                    }, label: {
                        Text("Place Order")
                    }).padding()
                }
            }
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
            
        }.navigationBarTitle(Text("Checkout"),displayMode: .inline)
    }
    
    func placeOrder(){
        guard let myOrder = try? JSONEncoder().encode(order)
            else {
                print("cant encode")
            return
        }
        guard let myUrl = URL(string: "https://reqres.in/api/cupcakes") else {
            print("cant convert myURL")
            return }
        var myRequest = URLRequest(url: myUrl)
        myRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        myRequest.httpMethod = "POST"
        myRequest.httpBody = myOrder
        
        URLSession.shared.dataTask(with: myRequest) { data,response,error in
            guard let myData = data else{
                showingAlert = true
                
                alertMessage = "\(error?.localizedDescription ?? "Internet Connection Problems")"
                alertTitle = "Error"
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: myData){
                alertMessage = "Your order for \(decodedOrder.cakeQty)x \(Order.types[decodedOrder.cakeType].lowercased()) cupcakes is on its way!"
                showingAlert = true
                alertTitle = "Thank you!"
            }
            else {
                showingAlert = true
                alertMessage = "\(error?.localizedDescription ?? "Internet Connection Problems")"
                alertTitle = "Error"
            }
        }.resume()
        
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
