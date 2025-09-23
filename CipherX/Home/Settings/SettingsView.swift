//
//  SettingsView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/27/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View
{
    @Environment(\.modelContext) var modelContext
    
    @Query var contacts: [Contact]
    @Query var keyPairs: [KeyPair]
    
    let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    
    @State private var presentAlert: Bool = false
    
    var body: some View
    {
        NavigationStack
        {
            List
            {
                Section(header: Text("Keys"))
                {
                    NavigationLink("Private Key")
                    {
                        PrivateKeyView()
                    }
                    NavigationLink("Public Key")
                    {
                        PublicKeyView()
                    }
                }
                
                Section
                {
                    Button(action: {presentAlert = true})
                    {
                        Text("Delete Data")
                            .foregroundStyle(.red)
                    }
                }
                
                Section
                {
                    HStack
                    {
                        Spacer()
                        Text("Version: \(appVersion)")
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .background(Constants().primaryColor)
            .alert("Erase all data?", isPresented: $presentAlert)
            {
                Button("Cancel", role: .cancel) {}
                Button("Erase", role: .destructive)
                {
                    self.eraseData()
                }
            }
        message:
            {
                Text("Your keys and contacts will be erased and will be unrecoverable. Are you sure?")
            }
        }
    }
    
    func eraseData()
    {
        for contact in contacts
        {
            modelContext.delete(contact)
        }
        
        for keyPair in keyPairs
        {
            modelContext.delete(keyPair)
        }
    }
}

#Preview
{
    NavigationStack
    {
        SettingsView()
    }
}
