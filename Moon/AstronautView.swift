//
//  AstronautView.swift
//  MoonShot
//
//  Created by Vahagn Martirosyan on 2021-01-08.
//

import SwiftUI

struct AstronautView: View {
    let astronaut:Astronaut
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var astronautMissions:[String]{
        var temp = [String]()
        for mis in missions{
            for cr in mis.crew {
                if astronaut.id == cr.name{
                    temp.append(mis.displayName)
                }
            }
        }
        return temp
    }
    
    
    var body: some View {
        
        GeometryReader{ geometry in
            ScrollView(.vertical){
                VStack{
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    Text(astronaut.description)
                        .padding()
                    
                    Text("Missions participated")
                        .font(.headline)
                    ForEach(astronautMissions,id:\.self){ mis in
                            Text(mis)
                                .font(.title)
                                .fontWeight(.heavy)
                    }
                }
            }
            
        }
        .navigationBarTitle(Text(astronaut.name),displayMode: .inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts:[Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        
        AstronautView(astronaut: astronauts[0])
    }
}
