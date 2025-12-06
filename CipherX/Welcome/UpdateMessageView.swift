//
//  UpdateMessageView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 12/4/25.
//

import SwiftUI

struct UpdateMessageView: View
{
    @Environment(\.dismiss) var dismiss
    
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(Constants().primaryColor)
                
                ScrollView
                {
                    VStack
                    {
                        HStack
                        {
                            VStack(alignment: .leading)
                            {
                                Text("Important Security Update")
                                    .font(.title)
                                    .foregroundStyle(.white)
                                Text("Version 1.1")
                                    .font(.title2)
                                    .foregroundStyle(Constants().secondaryColor)
                            }
                            
                            Spacer()
                        }
                        .padding(.bottom)
                        
                        VStack(alignment: .leading)
                        {
                            Text("Hello! If you’re new to this app, you can skip this message and get started. If you’re a returning user, you should read on.\n")
                            Text("CipherX has been upgraded with an important security improvement designed to better protect your private key.\n")
                            Text("Previously, your private key was stored in a less secure location on your device. While there is **no indication that any keys were ever compromised**, private keys will now be stored using Apple’s secure Keychain system to ensure the highest level of protection going forward.\n")
                            Text("Because of this change, your original key has been securely removed and you’ll be asked to generate a new one. This is why you’re seeing the initial setup screen again. **Your contacts are safe and will still be there after you complete setup.** Only the key was reset. Though it is recommended to tell your contacts to update their app and generate a new key.\n")
                            Text("I sincerely apologize for the inconvenience and truly appreciate your trust and support as CipherX continues to improve.\n")
                            Text("Thank you for using my app!\n")
                            Group
                            {
                                Text("- Nick")
                                Text("CipherX Developer")
                                    .foregroundStyle(Constants().secondaryColor)
                            }
                        }
                        .foregroundStyle(.white)
                    }
                    .padding()
                }
            }
            .toolbar
            {
                ToolbarItem(placement: .cancellationAction)
                {
                    Button(action: {dismiss()})
                    {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
    }
}

#Preview
{
    UpdateMessageView()
}
