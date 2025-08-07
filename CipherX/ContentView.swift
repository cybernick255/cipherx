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
    @Query var keyPair: [KeyPair]
    
    var body: some View
    {
        if keyPair.isEmpty
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
