//
//  EditNameView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 9/22/25.
//

import SwiftUI

struct EditNameView: View
{
    let contact: Contact

    @Environment(\.dismiss) var dismiss
    
    @State private var name: String
    
    init(contact: Contact)
    {
        self.contact = contact
        self.name = contact.name
    }
    
    var body: some View
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
            Button("Save")
            {
                contact.name = name
                dismiss()
            }
            .disabled(name.count <= 0 || name.count > 32)
        }
        .scrollContentBackground(.hidden)
        .background(Constants().primaryColor)
        .navigationTitle("Edit Contact Name")
    }
}

#Preview
{
    EditNameView(contact: Contact.sample)
}
