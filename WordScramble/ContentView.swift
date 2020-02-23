//
//  ContentView.swift
//  WordScramble
//
//  Created by Aaryan Kothari on 22/02/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

var people = ["A","B","C","D","E"]

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var newWord = String()
    @State private var rootWord = String()
    
    @State private var errorTitle = String()
    @State private var errorMessage = String()
    @State private var shwoingError = Bool()


    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter your word", text: $newWord, onCommit: addWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List(usedWords, id: \.self){
                    Image(systemName: "\($0.count).circle")
                    Text("\($0)")
                }
            }
        .navigationBarTitle(rootWord)
        .onAppear(perform: startGame)
            .alert(isPresented: $shwoingError){
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0  else{
                return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognised", message: "you cant just make em' up")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That is not a real word")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame(){
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
        
            if let startWords = try? String(contentsOf: startWordsUrl){
              
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                
                return
            }}
        
        fatalError("could not load start.txt from bundle")
    }
    
    func isOriginal(word : String) -> Bool {
        !usedWords.contains(newWord)
    }
    
    func isPossible(word : String) -> Bool {
        var tempWord = rootWord.lowercased()
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            }
            else{
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let missSpelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return missSpelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        shwoingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
