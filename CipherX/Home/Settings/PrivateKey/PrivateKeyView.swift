//
//  PrivateKeyView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/27/25.
//

import SwiftUI
import SwiftData

struct PrivateKeyView: View
{
    @Query var keyPairs: [KeyPair]
    
    @State private var showCopiedMessage: Bool = false
    @State private var showPrivateKey: Bool = false
    
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(Constants().primaryColor)
            
            VStack
            {
                Text("SENSITIVE DATA")
                    .font(.title)
                    .foregroundStyle(Constants().secondaryColor)
                Text("Only view this key in a secure environment.")
                    .foregroundStyle(Constants().secondaryColor)
                
                HStack
                {
                    Spacer()
                    Button(action: copyPrivateKeyToClipboard)
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
                
                VStack(alignment: .leading)
                {
                    Text("\(showPrivateKey ? keyPairs[0].privateKey : "(Hidden)")")
                }
                .padding(.top)
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
        .navigationTitle("Private Key")
        .animation(.easeInOut(duration: 0.5), value: showCopiedMessage)
        .toolbar
        {
            ToolbarItem(placement: .primaryAction)
            {
                Button(action: { showPrivateKey.toggle() })
                {
                    Image(systemName: showPrivateKey ? "eye.slash" : "eye")
                }
            }
        }
    }
    
    func copyPrivateKeyToClipboard()
    {
        UIPasteboard.general.string = self.keyPairs[0].privateKey
        self.showCopiedMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        {
            self.showCopiedMessage = false
        }
    }
}

#Preview
{
    PrivateKeyView()
}
