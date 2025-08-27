//
//  PublicKeyView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/27/25.
//

import SwiftUI
import SwiftData

struct PublicKeyView: View
{
    @Query var keyPairs: [KeyPair]
    
    @State private var showCopiedMessage: Bool = false
    
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(Constants().primaryColor)
            
            VStack
            {
                VStack(alignment: .leading)
                {
                    Text("Public Key")
                        .foregroundStyle(.white)
                    Text("\(keyPairs[0].publicKey)")
                        .foregroundStyle(Constants().secondaryColor)
                        .onTapGesture
                        {
                            self.copyPublicKeyToClipboard()
                        }
                }
                Spacer()
            }
            
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
        .navigationTitle("Public Key")
        .animation(.easeInOut(duration: 0.5), value: showCopiedMessage)
    }
    
    func copyPublicKeyToClipboard()
    {
        UIPasteboard.general.string = self.keyPairs[0].publicKey
        self.showCopiedMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        {
            self.showCopiedMessage = false
        }
    }
}

//#Preview
//{
//    PublicKeyView()
//}
