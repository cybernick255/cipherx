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
    @EnvironmentObject var appViewModel: CipherXAppViewModel
    
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
                    HStack
                    {
                        Spacer()
                        Button(action: copyPublicKeyToClipboard)
                        {
                            Image(systemName: "document.on.document")
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8)
                                    .fill(Constants().secondaryColor)
                                )
                                .foregroundStyle(.white)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.clear)
                            .stroke(.white, lineWidth: 2)
                    )
                    ScrollView
                    {
                        Text("\(appViewModel.privateKey!.publicKey.rawRepresentation.base64EncodedString())")
                    }
                }
                Spacer()
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
        .navigationTitle("Public Key")
        .animation(.easeInOut(duration: 0.5), value: showCopiedMessage)
    }
    
    func copyPublicKeyToClipboard()
    {
        UIPasteboard.general.string = appViewModel.privateKey!.publicKey.rawRepresentation.base64EncodedString()
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
