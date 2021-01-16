//
//  Order.swift
//  CupcakeCorner
//
//  Created by Vahagn Martirosyan on 2021-01-14.
//

import SwiftUI

class Order:ObservableObject,Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var cakeType = 0
    @Published var cakeQty = 3
    @Published var specialRequest = false{
        didSet{
            if specialRequest == false {
                extraFrosting = false
                extraSprinkles = false
            }
        }
    }
    
    @Published var extraFrosting = false
    @Published var extraSprinkles = false
    
    @Published var name = ""
    @Published var address = ""
    @Published var city = ""
    @Published var zip = ""
    var hasValidAddress: Bool {
        if name.isEmpty || city.isEmpty || zip.isEmpty || address.isEmpty{
        return false
            
        }
        else if address.trimmingCharacters(in: .whitespaces).isEmpty{
            return false
        }
        else {
            return true}
    }
    var cost: Double {
        // $2 per cake
        var cost = Double(cakeQty) * 2

        // complicated cakes cost more
        cost += (Double(cakeType) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(cakeQty)
        }

        // $0.50/cake for sprinkles
        if extraSprinkles {
            cost += Double(cakeQty) / 2
        }

        return cost
    }
    
    enum Coding: CodingKey{
        case cakeType,cakeQty,extraFrosting,extraSprinkles,name,address,city,zip
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Coding.self)
        try container.encode(cakeType, forKey: .cakeType)
        try container.encode(cakeQty, forKey: .cakeQty)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(extraSprinkles, forKey: .extraSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
        
        
    }
    
    required init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: Coding.self)
        cakeType = try container.decode(Int.self, forKey: .cakeType)
        cakeQty = try container.decode(Int.self, forKey: .cakeQty)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        extraSprinkles = try container.decode(Bool.self, forKey: .extraSprinkles)
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    init() {}
}
