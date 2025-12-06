//
//  GenerateKeysViewModel.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/7/25.
//

import SwiftUI
import CryptoKit

extension GenerateKeysView
{
    @Observable
    class ViewModel
    {
        var showCopiedMessage: Bool = false
        
        var alertShowing: Bool = false
        var alertTitle: String = ""
        var alertMessage: String = ""
        
        let privateKey: P384.KeyAgreement.PrivateKey
        let publicKey: P384.KeyAgreement.PublicKey
        
        let privateKeyString: String
        let publicKeyString: String
        
        init()
        {
            let privateKey = P384.KeyAgreement.PrivateKey()
            
            self.privateKey = privateKey
            self.publicKey = privateKey.publicKey
            
            self.privateKeyString = privateKey.rawRepresentation.base64EncodedString()
            self.publicKeyString = privateKey.publicKey.rawRepresentation.base64EncodedString()
        }
        
        func copyPrivateKeyToClipboard()
        {
            UIPasteboard.general.string = self.privateKeyString
            self.showCopiedMessage = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
                self.showCopiedMessage = false
            }
        }
        
        func copyPublicKeyToClipboard()
        {
            UIPasteboard.general.string = self.publicKeyString
            self.showCopiedMessage = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1)
            {
                self.showCopiedMessage = false
            }
        }
    }
}
