//
//  ContactView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/7/25.
//

import SwiftUI
import CryptoKit
import SwiftData

struct ContactView: View
{
    @Query var keyPairs: [KeyPair]
    
    let contact: Contact
    
    @State private var encryptedMessage: String = ""
    @State private var decryptedMessage: String = ""
    
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
                    Text("Encrypted Message")
                        .foregroundStyle(Constants().secondaryColor)
                        .onChange(of: encryptedMessage)
                        {
                            //self.decryptMessage()
                        }
                    TextField("", text: $encryptedMessage)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.bottom)
                
                VStack(alignment: .leading)
                {
                    Text("Decrypted Message")
                        .foregroundStyle(Constants().secondaryColor)
                    TextEditor(text: $decryptedMessage)
                        .scrollContentBackground(.hidden)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding()
        }
        .navigationTitle(contact.name)
    }
    
    // Not working
//    func decryptMessage()
//    {
//        let privateKey = generatePrivateKeyFrom(string: keyPairs[0].privateKey)
//        print(keyPairs[0].privateKey)
//        let publicKey = generatePublicKeyFrom(string: contact.publicKey)
//        let ciphersuite = HPKE.Ciphersuite.P384_SHA384_AES_GCM_256
//        let protocolInfo = "Contact Message".data(using: .utf8)!
//        let encapsulatedKey = generateEncapsulatedKey()
//        let ciphertext = generateCiphertext()
//        print("Encapsulated Key: \(encapsulatedKey.base64EncodedString())")
//        print(ciphertext)
//        let data = Data(base64Encoded: encryptedMessage)!
//        print("Combined raw byte count: \(data.count)")
//        print("Encapsulated key: \(data.prefix(96).base64EncodedString())")
//        var hpkeRecipient = try! HPKE.Recipient(privateKey: privateKey, ciphersuite: ciphersuite, info: protocolInfo, encapsulatedKey: encapsulatedKey)
//        
//        try! self.decryptedMessage = hpkeRecipient.open(ciphertext).base64EncodedString()
//    }
//    
//    func generatePrivateKeyFrom(string: String) -> P384.KeyAgreement.PrivateKey
//    {
//        let rawPrivateKeyData = Data(base64Encoded: string)!
//        
//        return try! P384.KeyAgreement.PrivateKey(rawRepresentation: rawPrivateKeyData)
//    }
//    
//    func generatePublicKeyFrom(string: String) -> P384.KeyAgreement.PublicKey
//    {
//        let rawPublicKeyData = Data(base64Encoded: string)!
//        
//        return try! P384.KeyAgreement.PublicKey(rawRepresentation: rawPublicKeyData)
//    }
//    
//    func generateEncryptedMessageDataFrom(string: String) -> Data
//    {
//        print(Data(base64Encoded: string)!)
//        return Data(base64Encoded: string)!
//    }
//    
//    func generateEncapsulatedKey() -> Data
//    {
//        let data = generateEncryptedMessageDataFrom(string: encryptedMessage)
//            let encapsulatedKey = data.prefix(96)
//
//            print("EncapsulatedKey byte count: \(encapsulatedKey.count)")  // Should be 96
//            print("EncapsulatedKey base64 length: \(encapsulatedKey.base64EncodedString().count)")  // Should be 128
//            print("EncapsulatedKey base64: \(encapsulatedKey.base64EncodedString())")
//
//            return encapsulatedKey
//        //return generateEncryptedMessageDataFrom(string: encryptedMessage).prefix(96)
//    }
//    
//    func generateCiphertext() -> Data
//    {
//        return generateEncryptedMessageDataFrom(string: encryptedMessage).suffix(from: 96)
//    }
}

#Preview
{
    ContactView(contact: Contact(name: "", publicKey: ""))
}
