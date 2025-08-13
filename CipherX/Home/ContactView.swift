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
                    Text("Decrypted Message")
                        .foregroundStyle(Constants().secondaryColor)
                    TextEditor(text: $decryptedMessage)
                        .scrollContentBackground(.hidden)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .onChange(of: decryptedMessage)
                        {
                            self.encryptMessage()
                        }
                }
                
                VStack(alignment: .leading)
                {
                    Text("Encrypted Message")
                        .foregroundStyle(Constants().secondaryColor)
                    TextField("", text: $encryptedMessage)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.bottom)
            }
            .padding()
        }
        .navigationTitle(contact.name)
    }
    
    func encryptMessage()
    {
        let publicKey = try! generatePublicKeyFrom(string: contact.publicKey)
        let ciphersuite = HPKE.Ciphersuite.P384_SHA384_AES_GCM_256
        let protocolInfo = "Messages".data(using: .utf8)!
        var hpkeSender = try! HPKE.Sender(
            recipientKey: publicKey,
            ciphersuite: ciphersuite,
            info: protocolInfo)
        
        let decryptedMessageData = decryptedMessage.data(using: .utf8)!
        let ciphertext = try! hpkeSender.seal(decryptedMessageData)
        let encapsulatedKey = hpkeSender.encapsulatedKey
        
        self.encryptedMessage = exportEncryptedMessage(ciphertext, encapsulatedKey: encapsulatedKey)
    }
    
    func generatePublicKeyFrom(string: String) throws -> P384.KeyAgreement.PublicKey
    {
        let data = Data(base64Encoded: string)!
        return try P384.KeyAgreement.PublicKey(rawRepresentation: data)
    }
    
    func exportEncryptedMessage(_ ciphertext: Data, encapsulatedKey: Data) -> String
    {
        let ciphertextString = ciphertext.base64EncodedString()
        let encapsulatedKeyString = encapsulatedKey.base64EncodedString()
        return "\(ciphertextString),\(encapsulatedKeyString)"
    }
}

#Preview
{
    ContactView(contact: Contact(name: "", publicKey: ""))
}
