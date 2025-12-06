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
    @EnvironmentObject var appViewModel: CipherXAppViewModel
    @Environment(\.modelContext) var modelContext
    
    @Query var contacts: [Contact]
    
    let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    
    @State private var presentAlert: Bool = false
    @State private var presentErrorAlert: Bool = false
    
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
            .alert(isPresented: $presentErrorAlert)
            {
                Alert(
                    title: Text("Error"),
                    message: Text("Failed to delete private key.")
                )
            }
        }
    }
    
    func eraseData()
    {
        for contact in contacts
        {
            modelContext.delete(contact)
        }
        
        do
        {
            try appViewModel.deletePrivateKeyFromKeychain()
        }
        catch
        {
            presentErrorAlert = true
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
