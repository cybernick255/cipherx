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
    @EnvironmentObject var appViewModel: CipherXAppViewModel
    
    var body: some View
    {
        if appViewModel.privateKey == nil
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
