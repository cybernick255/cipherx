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
                
                Section(header: Text("Other"))
                {
                    Link(destination: URL(string: "https://github.com/cybernick255/cipherx")!)
                    {
                        Label {
                            Text("Open Source Code")
                        } icon: {
                            Image("GitHub_Invertocat_Light")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20) // or 17 to match default symbol size
                        }
                    }
                    
                    Button(action: sendFeedback)
                    {
                        Label("Feedback", systemImage: "envelope")
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
    
    private func sendFeedback()
    {
        let email: String = "cybernick255@proton.me"
        let subject: String = "CipherX - Feedback"
        let urlString: String = "mailto:\(email)?subject=\(subject)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        if let url = URL(string: urlString)
        {
            UIApplication.shared.open(url)
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
