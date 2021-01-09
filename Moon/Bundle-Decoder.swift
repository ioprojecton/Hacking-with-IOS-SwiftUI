//
//  Bundle-Decoder.swift
//  MoonShot
//
//  Created by Vahagn Martirosyan on 2021-01-07.
//

import Foundation

extension Bundle{
    func decode<T: Codable>(_ fileName:String) -> T {
    if let locatingFile = url(forResource: fileName, withExtension: nil){
        if let data = try? Data(contentsOf: locatingFile){
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "y-MM-dd"
            decoder.dateDecodingStrategy = .formatted(formatter)
            
            if let success = try? decoder.decode(T.self, from: data){
                return success
            }
            else {
                fatalError("cant decode")
            }
        }
        else{
            fatalError("Cant load data")
        }
    }
    else{
        fatalError("Cant locate file")
    }
    
}
}
