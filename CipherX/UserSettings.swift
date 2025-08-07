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
    
    func saveKeyPair(keyPair: KeyPair)
    {
        self.keyPair = keyPair
    }
    
    func importKeyPair(string: String)
    {
        let privateKey = generatePrivateKeyFrom(string: string)
        let publicKey = privateKey.publicKey
        
        let privateKeyString = privateKey.rawRepresentation.base64EncodedString()
        let publicKeyString = publicKey.rawRepresentation.base64EncodedString()
        
        self.keyPair = KeyPair(privateKey: privateKeyString, publicKey: publicKeyString)
    }
    
    func generatePrivateKeyFrom(string: String) -> P384.KeyAgreement.PrivateKey
    {
        let rawPrivateKeyData = Data(base64Encoded: string)!
        
        return try! P384.KeyAgreement.PrivateKey(rawRepresentation: rawPrivateKeyData)
    }
    
    func generatePublicKeyFrom(string: String) -> P384.KeyAgreement.PublicKey
    {
        let rawPublicKeyData = Data(base64Encoded: string)!
        
        return try! P384.KeyAgreement.PublicKey(rawRepresentation: rawPublicKeyData)
    }
    
    func encryptMessage()
    {
        
    }
    
    func decryptMessage()
    {
        
    }
}
