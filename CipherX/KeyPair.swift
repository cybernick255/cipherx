//
//  KeyPair.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/5/25.
//

import Foundation
import CryptoKit

struct KeyPair: Codable
{
    /// Convert to `P384.KeyAgreement.PrivateKey` when using.
    let privateKey: String
    /// Convert to `P384.KeyAgreement.PublicKey` when using.
    let publicKey: String
    
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
