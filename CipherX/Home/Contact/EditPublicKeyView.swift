//
//  EditPublicKeyView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 9/22/25.
//

import SwiftUI
import CryptoKit

struct EditPublicKeyView: View
{
    let contact: Contact

    @Environment(\.dismiss) var dismiss
    
    @State private var publicKey: String
    @State private var errorMessage: String?
    @State private var alertPresented: Bool = false
    
    init(contact: Contact)
    {
        self.contact = contact
        self.publicKey = contact.publicKey
    }
    
    var body: some View
    {
        Form
        {
            TextField("Public Key", text: $publicKey)
            Button("Save")
            {
                savePublicKey()
            }
            .disabled(publicKey.count < 128 || publicKey.count > 128)
        }
        .navigationTitle("Edit Contact Public Key")
        .alert("Error", isPresented: $alertPresented)
        {
            Button("Okay", role: .cancel)
            {
                self.errorMessage = nil
            }
        }
    message:
        {
            Text(errorMessage ?? "Unknown error.")
        }
    }
    
    func savePublicKey()
    {
        if testPublicKeyValidity()
        {
            contact.publicKey = publicKey
            dismiss()
        }
    }
    
    /// This tests the inputted key to see if it is valid. Returns "true" if valid.
    func testPublicKeyValidity() -> Bool
    {
        do
        {
            _ = try generatePublicKeyFrom(string: publicKey)
            
            return true
        }
        catch
        {
            self.errorMessage = error.localizedDescription
            self.alertPresented = true
            
            return false
        }
    }
    
    func generatePublicKeyFrom(string: String) throws -> P384.KeyAgreement.PublicKey?
    {
        guard let data = Data(base64Encoded: string)
        else
        {
            throw GeneratePublicKeyError.invalidPublicKey
        }
        
        do
        {
            let publicKey = try P384.KeyAgreement.PublicKey(rawRepresentation: data)
            
            _ = try testEncryption(publicKey: publicKey)
            
            return publicKey
        }
        catch
        {
            throw GeneratePublicKeyError.invalidPublicKey
        }
    }
    
    func testEncryption(publicKey: P384.KeyAgreement.PublicKey) throws
    {
        do
        {
            let ciphersuite = HPKE.Ciphersuite.P384_SHA384_AES_GCM_256
            let protocolInfo = "Messages".data(using: .utf8)!
            var hpkeSender = try HPKE.Sender(
                recipientKey: publicKey,
                ciphersuite: ciphersuite,
                info: protocolInfo)
            
            let decryptedMessageData = "testing".data(using: .utf8)!
            _ = try hpkeSender.seal(decryptedMessageData)
            _ = hpkeSender.encapsulatedKey
        }
        catch
        {
            throw GeneratePublicKeyError.invalidPublicKey
        }
    }
    
    enum GeneratePublicKeyError: LocalizedError
    {
        case invalidPublicKey
        
        var errorDescription: String?
        {
            switch self
            {
            case .invalidPublicKey:
                return "Invalid public key."
            }
        }
    }
}

#Preview
{
    EditPublicKeyView(contact: Contact.sample)
}
