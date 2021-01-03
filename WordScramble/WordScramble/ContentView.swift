//
//  ContentView.swift
//  WordScramble
//
//  Created by Vahagn Martirosyan on 2021-01-02.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter your word here", text: $newWord, onCommit: {
                    addNewWord()
                })
                .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                List(usedWords, id: \.self){ words in
                    Image(systemName: "\(words.count).circle.fill")
                    Text(words)
                }
                Text("Your Score: \(score)")
                    .font(.headline)
                    .font(.system(.headline, design: .rounded))
                    .padding()
            }
            .navigationBarItems(leading: Button(action: {
                startGame()
            }, label: {
                Text("Restart")
                    .fontWeight(.heavy)
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.green)
            }))
            .navigationBarTitle(Text(rootWord))
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError, content: {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            })
        }
        
    }
    
    func addNewWord(){
        guard !newWord.isEmpty else {
            return
        }
        
        newWord = newWord.lowercased().trimmingCharacters(in: .whitespaces)
        
        guard isOriginal(word: newWord) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: newWord) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        guard isReal(word: newWord) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }
        
        usedWords.insert(newWord, at: 0)
        score += newWord.count + 1 // letters used in word and right word itself
        newWord = ""
        
        
        
        
    }
    
    func startGame(){
        if let fileFound = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let newString = try?String(contentsOf: fileFound){
                let newStringArray = newString.components(separatedBy: .whitespacesAndNewlines)
                rootWord = newStringArray.randomElement() ?? "silkWorm"
                return
            }
        }
        fatalError("Something went wrong")
    }
    
    func isOriginal(word:String) -> Bool{
        !usedWords.contains(word)
    }
    
    func isPossible(word:String) -> Bool{
        var tempWord = rootWord
        guard word != rootWord else {
            return false
        }
        for char in word{
            if let pos = tempWord.firstIndex(of: char){
                tempWord.remove(at: pos)
            }
            else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        if word.count < 3 {
            return false
        }
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
