//
//  DecryptView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/13/25.
//

import SwiftUI
import CryptoKit
import SwiftData

struct DecryptView: View
{
    @Query var keyPairs: [KeyPair]
    
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
                            self.decryptMessage()
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
    }
    
    func decryptMessage()
    {
        let encryptedMessage = importEncryptedMessage(encryptedMessage)
        
        let privateKey = generatePrivateKeyFrom(string: keyPairs[0].privateKey)
        let ciphersuite = HPKE.Ciphersuite.P384_SHA384_AES_GCM_256
        let protocolInfo = "Messages".data(using: .utf8)!
        let encapsulatedKey = encryptedMessage.encapsulatedKey
        
        var hpkeRecipient =
        try! HPKE.Recipient(
            privateKey: privateKey,
            ciphersuite: ciphersuite,
            info: protocolInfo,
            encapsulatedKey: encapsulatedKey
        )
        
        let decryptedCiphertextData = try! hpkeRecipient.open(encryptedMessage.ciphertext)
        let decryptedCiphertextString = String(data: decryptedCiphertextData, encoding: .utf8)!
        
        decryptedMessage = decryptedCiphertextString
    }
    
    func generatePrivateKeyFrom(string: String) -> P384.KeyAgreement.PrivateKey
    {
        let rawPrivateKeyData = Data(base64Encoded: string)!
        
        return try! P384.KeyAgreement.PrivateKey(rawRepresentation: rawPrivateKeyData)
    }
    
    func importEncryptedMessage(_ encryptedMessageString: String) -> EncryptedMessage
    {
        let parts = encryptedMessageString.split(separator: ",")
        
        let ciphertextData = Data(base64Encoded: String(parts[0]))!
        let encapsulatedKeyData = Data(base64Encoded: String(parts[1]))!
        
        return EncryptedMessage(ciphertext: ciphertextData, encapsulatedKey: encapsulatedKeyData)
    }
}

#Preview
{
    DecryptView()
}
