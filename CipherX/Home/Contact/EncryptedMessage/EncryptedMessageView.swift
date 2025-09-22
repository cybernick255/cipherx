//
//  EncryptedMessageView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 9/22/25.
//

import SwiftUI

struct EncryptedMessageView: View
{
    let encryptedMessage: String
    
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
                HStack
                {
                    Spacer()
                    Button(action: copyToClipboard)
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
                    Text(encryptedMessage)
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
        .navigationTitle("Encrypted Message")
        .navigationBarTitleDisplayMode(.inline)
        .animation(.easeInOut(duration: 0.5), value: showCopiedMessage)
    }
    
    func copyToClipboard()
    {
        UIPasteboard.general.string = self.encryptedMessage
        self.showCopiedMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        {
            self.showCopiedMessage = false
        }
    }
}

#Preview
{
    EncryptedMessageView(encryptedMessage: "iKLsJtW40LbcuQCO8Pn5YeXg,BBkTi2pXV+PpQLtwQ2Emrqw9saFU6lmSbKBV5eFLWXLKnzic4oeeONPk8c7f01dLA5w337TSzWZsRFTcIIG5TuHg9J+C2Hdqz0voCtPwoUThqAQ13bYutgfoh3fFcoK1qw==")
}
