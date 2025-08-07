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
    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
        }
        .modelContainer(for: KeyPair.self)
    }
}
