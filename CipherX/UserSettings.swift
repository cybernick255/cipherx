//
//  UserSettings.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/5/25.
//

import Foundation
import CryptoKit

class UserSettings: ObservableObject
{
    @Published var keyPair: KeyPair?
    @Published var userReady: Bool
    
    init()
    {
        self.userReady = false
    }
    
    func generateKeyPair()
    {
        let privateKey = P384.KeyAgreement.PrivateKey()
        let publicKey = privateKey.publicKey
        
        self.keyPair = KeyPair(privateKey: privateKey, publicKey: publicKey)
    }
    
    func importKeyPair(string: String) -> KeyPair
    {
        let rawData = Data(base64Encoded: string)!
        
        let privateKey = try! P384.KeyAgreement.PrivateKey(rawRepresentation: rawData)
        let publicKey = privateKey.publicKey
        return KeyPair(privateKey: privateKey, publicKey: publicKey)
    }
    
    func generatePrivateKeyString() -> String
    {
        if let keyPair = self.keyPair
        {
            return keyPair.privateKey.rawRepresentation.base64EncodedString()
        }
        
        return "Not Available"
    }
    
    func generatePublicKeyString() -> String
    {
        if let keyPair = self.keyPair
        {
            return keyPair.publicKey.rawRepresentation.base64EncodedString()
        }
        
        return "Not Available"
    }
    
    func generatePublicKeyData(string: String) -> P384.KeyAgreement.PublicKey
    {
        let rawData = Data(base64Encoded: string)!
        
        return try! P384.KeyAgreement.PublicKey(rawRepresentation: rawData)
    }
    
    func encryptMessage()
    {
        
    }
    
    func decryptMessage()
    {
        
    }
}
