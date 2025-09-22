//
//  AddContactView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/7/25.
//

import SwiftUI
import CryptoKit

struct AddContactView: View
{
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var publicKey: String = ""
    @State private var errorMessage: String?
    @State private var alertPresented: Bool = false
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                TextField("Name", text: $name)
                    .onChange(of: name)
                    { oldValue, newValue in
                        // Respond to name changes if needed
                        if newValue.count > 32
                        {
                            name = oldValue
                        }
                    }
                TextField("Public Key", text: $publicKey)
                
                Button("Save")
                {
                    saveContact()
                }
                .disabled(publicKey.count < 128 || publicKey.count > 128 || name.isEmpty)
            }
            .navigationTitle("Add Contact")
        }
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
    
    func saveContact()
    {
        do
        {
            // This tests the inputted key to see if it is valid.
            _ = try generatePublicKeyFrom(string: publicKey)
            
            modelContext.insert(Contact(name: name, publicKey: publicKey))
            dismiss()
        }
        catch
        {
            self.errorMessage = error.localizedDescription
            self.alertPresented = true
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
            
            _ = try testPublicKeyValidity(publicKey: publicKey)
            
            return publicKey
        }
        catch
        {
            throw GeneratePublicKeyError.invalidPublicKey
        }
    }
    
    func testPublicKeyValidity(publicKey: P384.KeyAgreement.PublicKey) throws
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
    AddContactView()
}
