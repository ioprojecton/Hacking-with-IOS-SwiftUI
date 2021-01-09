//
//  Mission.swift
//  MoonShot
//
//  Created by Vahagn Martirosyan on 2021-01-07.
//

import Foundation


struct Mission: Identifiable, Codable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    var formattedLaunchDate: String {
        if let newLaunchDate = launchDate{
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: newLaunchDate)
        }
            else {
                return "N/A"
            }
    }
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var displayImage: String{
        "apollo\(id)"
    }
}
