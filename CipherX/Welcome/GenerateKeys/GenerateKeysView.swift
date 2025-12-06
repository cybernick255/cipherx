//
//  GenerateKeysView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/4/25.
//

import SwiftUI

struct GenerateKeysView: View
{
    @EnvironmentObject var appViewModel: CipherXAppViewModel
    
    @State private var viewModel = ViewModel()
    
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(Constants().primaryColor)
            
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
                
                HStack
                {
                    VStack(alignment: .leading)
                    {
                        Text("Private Key")
                            .foregroundStyle(.white)
                        Text("\(viewModel.privateKeyString)")
                            .foregroundStyle(Constants().secondaryColor)
                            .onTapGesture
                            {
                                self.viewModel.copyPrivateKeyToClipboard()
                            }
                    }
                    Spacer()
                }
                .padding(.bottom)
                
                HStack
                {
                    VStack(alignment: .leading)
                    {
                        Text("Public Key")
                            .foregroundStyle(.white)
                        Text("\(viewModel.publicKeyString)")
                            .foregroundStyle(Constants().secondaryColor)
                            .onTapGesture
                            {
                                self.viewModel.copyPublicKeyToClipboard()
                            }
                    }
                    Spacer()
                }
                
                Spacer()
                
                Button(action: savePrivateKey)
                {
                    Text("Continue")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8)
                            .fill(Constants().secondaryColor)
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
        .alert(isPresented: $viewModel.alertShowing)
        {
            Alert(
                title: Text(viewModel.alertTitle),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(
                    Text("OK"),
                    action: dismissAlert
                )
            )
        }
        .onAppear
        {
            self.viewModel = ViewModel()
        }
    }
    
    func savePrivateKey()
    {
        do
        {
            try appViewModel.storePrivateKeyInKeychain(privateKey: viewModel.privateKey)
        }
        catch
        {
            viewModel.alertTitle = "Error"
            viewModel.alertMessage = "Failed to save private key."
            viewModel.alertShowing = true
        }
    }
    
    func dismissAlert()
    {
        viewModel.alertTitle = ""
        viewModel.alertMessage = ""
    }
}

#Preview
{
    GenerateKeysView()
}
