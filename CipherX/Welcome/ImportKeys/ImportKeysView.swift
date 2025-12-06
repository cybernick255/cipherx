//
//  ImportKeysView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/4/25.
//

import SwiftUI
import CryptoKit

struct ImportKeysView: View
{
    @EnvironmentObject var appViewModel: CipherXAppViewModel
    
    @State private var privateKeyString: String = ""
    @State private var errorMessage: String?
    @State private var alertPresented: Bool = false
    
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(Constants().primaryColor)
            
            VStack
            {
                HStack
                {
                    Text("Private Key")
                        .foregroundStyle(Constants().secondaryColor)
                    Spacer()
                }
                TextField("Private Key", text: $privateKeyString)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Button(action: submitKey)
                {
                    Text("Submit")
                        .padding()
                        .background(Capsule().foregroundStyle(Constants().secondaryColor))
                        .foregroundStyle(.white)
                }
                .padding(.top)
            }
            .padding()
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
    
    func submitKey()
    {
        do
        {
            let privateKey = try importPrivateKey(privateKeyString)
            
            self.savePrivateKey(privateKey: privateKey)
        }
        catch
        {
            self.errorMessage = error.localizedDescription
            self.alertPresented = true
        }
    }
    
    func importPrivateKey(_ base64EncodedString: String) throws -> P384.KeyAgreement.PrivateKey
    {
        guard let data = Data(base64Encoded: base64EncodedString)
        else
        {
            throw ImportPrivateKeyError.nilKeyData
        }
        
        do
        {
            let key = try P384.KeyAgreement.PrivateKey(rawRepresentation: data)
            return key
        }
        catch
        {
            throw ImportPrivateKeyError.invalidKeyData
        }
    }
    
    func savePrivateKey(privateKey: P384.KeyAgreement.PrivateKey)
    {
        do
        {
            try appViewModel.storePrivateKeyInKeychain(privateKey: privateKey)
        }
        catch
        {
            errorMessage = error.localizedDescription
            alertPresented = true
        }
    }
    
    enum ImportPrivateKeyError: LocalizedError
    {
        case invalidKeyData
        case nilKeyData
        
        var errorDescription: String?
        {
            switch self
            {
            case .invalidKeyData:
                return "Invalid key data. (0)"
            case .nilKeyData:
                return "Invalid key data. (1)"
            }
        }
    }
}

#Preview
{
    ImportKeysView()
}
