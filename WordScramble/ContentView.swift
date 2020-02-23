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
        }
    }
    
    func addWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0  else{
                return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
