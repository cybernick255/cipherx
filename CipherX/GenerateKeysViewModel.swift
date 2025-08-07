//
//  GenerateKeysViewModel.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/7/25.
//

import SwiftUI

extension GenerateKeysView
{
    @Observable
    class ViewModel
    {
        var showCopiedMessage: Bool = false
        var keyPair = KeyPair()
        
        func copyPrivateKeyToClipboard()
        {
            UIPasteboard.general.string = self.keyPair.privateKey
            self.showCopiedMessage = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
                self.showCopiedMessage = false
            }
        }
        
        func copyPublicKeyToClipboard()
        {
            UIPasteboard.general.string = self.keyPair.publicKey
            self.showCopiedMessage = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
                self.showCopiedMessage = false
            }
        }
    }
}
