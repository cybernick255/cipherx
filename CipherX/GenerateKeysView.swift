//
//  GenerateKeysView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/4/25.
//

import SwiftUI

struct GenerateKeysView: View
{
    @Environment(\.modelContext) var modelContext
    
    @State private var viewModel = ViewModel()
    
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
                    Text("\(viewModel.keyPair.privateKey)")
                        .foregroundStyle(secondaryColor)
                        .onTapGesture
                        {
                            self.viewModel.copyPrivateKeyToClipboard()
                        }
                }
                .padding(.bottom)
                
                VStack(alignment: .leading)
                {
                    Text("Public Key")
                        .foregroundStyle(.white)
                    Text("\(viewModel.keyPair.publicKey)")
                        .foregroundStyle(secondaryColor)
                        .onTapGesture
                        {
                            self.viewModel.copyPublicKeyToClipboard()
                        }
                }
                
                Spacer()
                
                Button(action: saveKeyPair)
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
            
            if viewModel.showCopiedMessage
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
        .animation(.easeInOut(duration: 0.5), value: viewModel.showCopiedMessage)
    }
    
    func saveKeyPair()
    {
        modelContext.insert(viewModel.keyPair)
    }
}

#Preview
{
    GenerateKeysView()
}
