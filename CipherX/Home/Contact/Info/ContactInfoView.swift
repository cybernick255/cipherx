//
//  ContactInfoView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 9/22/25.
//

import SwiftUI

struct ContactInfoView: View
{
    let contact: Contact
    
    var body: some View
    {
        NavigationStack
        {
            List
            {
                Section(header: Text("Name"))
                {
                    NavigationLink(contact.name)
                    {
                        EditNameView(contact: contact)
                    }
                }
                Section(header: Text("Public Key"))
                {
                    NavigationLink(contact.publicKey)
                    {
                        EditPublicKeyView(contact: contact)
                    }
                }
            }
        }
    }
}

#Preview
{
    ContactInfoView(contact: Contact.sample)
}
