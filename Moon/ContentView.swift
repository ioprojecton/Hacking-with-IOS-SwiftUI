//
//  ContentView.swift
//  MoonShot
//
//  Created by Vahagn Martirosyan on 2021-01-07.
//

import SwiftUI



struct ContentView: View {
    let astronauts:[Astronaut] = Bundle.main.decode("astronauts.json")
    let missions:[Mission] = Bundle.main.decode("missions.json")
    @State private var showingDates = false
    
    
    var body: some View {
        
        NavigationView{
            List(missions){mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronauts: astronauts),
                    label: {
                        Image(mission.displayImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width:40, height: 40)
                        VStack(alignment: .leading){
                            Text(mission.displayName)
                                .font(.headline)
                            
                            Text(showingDates ? mission.formattedLaunchDate : crewNames(actualMission: mission))
                        }
                        
                    })
                
            }
            .navigationBarItems(trailing: Button(action: {
                showingDates.toggle()
            }, label: {
                Text(showingDates ? "Crew" : "Dates")
            }))
            
            .navigationBarTitle("MoonShot")
            
        }
        
    }
    
    func crewNames(actualMission: Mission) -> String{
        var temp = [String]()
        for crewName in actualMission.crew{
            temp.append(crewName.name.capitalized)
        }
        
        return temp.joined(separator: ", ")
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


