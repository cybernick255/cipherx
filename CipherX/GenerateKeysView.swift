//
//  GenerateKeysView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/4/25.
//

import SwiftUI

struct GenerateKeysView: View
{
    @EnvironmentObject var userSettings: UserSettings
    @State private var showCopiedMessage: Bool = false
    @State private var keyPair = KeyPair()
    
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(primaryColor)
            
            VStack
            {
                Text("Save Your Keys")
                    .font(.title)
                    .foregroundStyle(.white)
                Text("Tap keys to copy them to clipboard.")
                    .foregroundStyle(.white)
                Spacer()
            }
            
            VStack
            {
                
                Spacer()
                
                VStack(alignment: .leading)
                {
                    Text("Private Key")
                        .foregroundStyle(.white)
                    Text("\(keyPair.privateKey)")
                        .foregroundStyle(secondaryColor)
                        .onTapGesture
                        {
                            self.copyPrivateKeyToClipboard()
                        }
                }
                .padding(.bottom)
                
                VStack(alignment: .leading)
                {
                    Text("Public Key")
                        .foregroundStyle(.white)
                    Text("\(keyPair.publicKey)")
                        .foregroundStyle(secondaryColor)
                        .onTapGesture
                        {
                            self.copyPublicKeyToClipboard()
                        }
                }
                
                Spacer()
                
                Button(action: logInUser)
                {
                    Text("Continue")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8)
                            .fill(secondaryColor)
                        )
                        .foregroundStyle(.white)
                }
            }
            .padding()
            
            if showCopiedMessage
            {
                Text("Copied to clipboard!")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black.opacity(0.7))
                    .clipShape(.rect(cornerRadius: 8))
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: showCopiedMessage)
    }
    
    func logInUser()
    {
        userSettings.keyPair = self.keyPair
        userSettings.userReady = true
    }
    
    func copyPrivateKeyToClipboard()
    {
        UIPasteboard.general.string = keyPair.privateKey
        showCopiedMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        {
            showCopiedMessage = false
        }
    }
    
    func copyPublicKeyToClipboard()
    {
        UIPasteboard.general.string = keyPair.publicKey
        showCopiedMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        {
            showCopiedMessage = false
        }
    }
}

#Preview
{
    GenerateKeysView()
        .environmentObject(UserSettings())
}
