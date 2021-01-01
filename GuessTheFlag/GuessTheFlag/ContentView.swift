//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Vahagn Martirosyan on 2020-12-31.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia","Germany","Russia","France","Ireland","Italy","Monaco","Nigeria","Poland","Spain","UK","US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreTitle2 = ""
    @State private var score = 0
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                VStack(spacing:30){
                    VStack{
                        Text("Tap the number of")
                        Text(countries[correctAnswer])
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }.foregroundColor(.white)
                    
                    ForEach(0..<3,id:\.self){ count in
                        Button(action: {
                            chosenFlag(a: count)
                        }, label: {
                            FlagImage(countryName: countries[count])
                        })
                    }
                    Text("Your score: \(score)")
                        .foregroundColor(.white)
                        .font(.title)
                    Spacer()
                }.padding()
            }.navigationBarTitle("Guess the Flag",displayMode: .inline)
            .alert(isPresented: $showingScore, content: {
                Alert(title: Text(scoreTitle), message: Text(scoreTitle2), dismissButton: .default(Text("Continue")){
                    askQuestion()
                })
            })
          
        }
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func chosenFlag(a:Int){
        
        if a == correctAnswer{
            scoreTitle = "Correct"
            score += 1
        }
        else {
            scoreTitle = "Wrong"
            scoreTitle2 = "Thats the flag of \(countries[a])"
            score = score == 0 ? 0 : score - 1
        }
        
        showingScore = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: View {
    var countryName: String
    var body: some View{
        Image(countryName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black,lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}
