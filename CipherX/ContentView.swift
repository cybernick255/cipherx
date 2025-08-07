//
//  ContentView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/4/25.
//

import SwiftUI

struct ContentView: View
{
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View
    {
        if userSettings.keyPair == nil || userSettings.userReady == false
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
        .environmentObject(UserSettings())
}
