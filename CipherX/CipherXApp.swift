//
//  CipherXApp.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/4/25.
//

import SwiftUI
import SwiftData

@main
struct CipherXApp: App
{
    @StateObject private var appViewModel = CipherXAppViewModel()
    
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .preferredColorScheme(.dark)
                .environmentObject(appViewModel)
        }
        .modelContainer(for: [Contact.self])
    }
}
