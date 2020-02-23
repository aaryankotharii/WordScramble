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
    var body: some View {
        List {
            ForEach(people, id: \.self){
                Text("\($0)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
