//
//  ContentView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/4/25.
//

import SwiftUI
import SwiftData

struct ContentView: View
{
    @Query var keyPairs: [KeyPair]
    
    var body: some View
    {
        if keyPairs.isEmpty
        {
            WelcomeView()
        }
        else
        {
            HomeView()
        }
    }
}

#Preview
{
    ContentView()
}
