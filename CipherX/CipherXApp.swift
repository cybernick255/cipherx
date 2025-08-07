//
//  CipherXApp.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/4/25.
//

import SwiftUI

@main
struct CipherXApp: App
{
    @StateObject var userSettings = UserSettings()
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .environmentObject(userSettings)
        }
    }
}
