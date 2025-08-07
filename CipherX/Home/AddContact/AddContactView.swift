//
//  AddContactView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/7/25.
//

import SwiftUI

struct AddContactView: View
{
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var publicKey: String = ""
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                TextField("Name", text: $name)
                TextField("Public Key", text: $publicKey)
                
                Button("Save")
                {
                    saveContact()
                }
                .disabled(publicKey.count < 128 || publicKey.count > 128 || name.isEmpty)
            }
            .navigationTitle("Add Contact")
        }
    }
    
    func saveContact()
    {
        modelContext.insert(Contact(name: name, publicKey: publicKey))
        dismiss()
    }
}

#Preview
{
    AddContactView()
}
