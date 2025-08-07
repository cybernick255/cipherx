//
//  KeyPair.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/5/25.
//

import Foundation
import CryptoKit
import SwiftData

@Model
class KeyPair
{
    /// Convert to `P384.KeyAgreement.PrivateKey` when using.
    private(set) var privateKey: String
    /// Convert to `P384.KeyAgreement.PublicKey` when using.
    private(set) var publicKey: String
    
    init()
    {
        let privateKey = P384.KeyAgreement.PrivateKey()
        let publicKey = privateKey.publicKey
        
        self.privateKey = privateKey.rawRepresentation.base64EncodedString()
        self.publicKey = publicKey.rawRepresentation.base64EncodedString()
    }
    
    init(privateKey: String, publicKey: String)
    {
        self.privateKey = privateKey
        self.publicKey = publicKey
    }
}
