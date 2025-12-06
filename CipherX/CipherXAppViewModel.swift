//
//  CipherXAppViewModel.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 11/30/25.
//

import SwiftUI
import CryptoKit

class CipherXAppViewModel: ObservableObject
{
    @Published var privateKey: P384.KeyAgreement.PrivateKey?
    
    private let keyStore = SecKeyStore()
    private let label = Constants().labelSecKeyPrivateKey
    
    var tempPrivateKey: P384.KeyAgreement.PrivateKey?
    
    init()
    {
        loadPrivateKey()
    }
    
    func loadPrivateKey()
    {
        do
        {
            let key: P384.KeyAgreement.PrivateKey? = try keyStore.readKey(label: label)
            
            self.privateKey = key
        }
        catch
        {
            print("Failed to read key: \(error)")
        }
    }
    
    func storePrivateKeyInKeychain(privateKey: P384.KeyAgreement.PrivateKey) throws
    {
        let _ = try keyStore.roundTrip(privateKey)
        loadPrivateKey()
    }
    
    func deletePrivateKeyFromKeychain() throws
    {
        try keyStore.deleteKey(label: label)
        
        self.privateKey = nil
    }
}
