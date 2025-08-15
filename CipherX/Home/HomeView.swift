//
//  HomeView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/5/25.
//

import SwiftUI
import SwiftData

struct HomeView: View
{
    @Environment(\.modelContext) var modelContext
    
    @Query var contacts: [Contact]
    @Query var keyPairs: [KeyPair]
    
    let options: [String] = ["Decrypt", "Encrypt"]
    
    @State private var presentSheet: Bool = false
    @State private var option: String = "Decrypt"
    @State private var presentAlert: Bool = false
    
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(Constants().primaryColor)
                VStack
                {
                    Picker("Select option", selection: $option)
                    {
                        ForEach(options, id: \.self)
                        { option in
                            Text(option)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    if option == "Decrypt"
                    {
                        DecryptView()
                    }
                    else
                    {
                        List
                        {
                            ForEach(contacts)
                            { contact in
                                NavigationLink(destination: ContactView(contact: contact))
                                {
                                    Text(contact.name)
                                }
                            }
                            .onDelete(perform: deleteContact)
                        }
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle("Home")
            .alert("Erase all data?", isPresented: $presentAlert)
            {
                Button("Cancel", role: .cancel) {}
                Button("Erase", role: .destructive)
                {
                    self.eraseData()
                }
            }
        message:
            {
                Text("Your keys and contacts will be erased and will be unrecoverable. Are you sure?")
            }
            .sheet(isPresented: $presentSheet)
            {
                AddContactView()
            }
            .toolbar
            {
                ToolbarItem(placement: .primaryAction)
                {
                    Button(action: { presentSheet = true })
                    {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .cancellationAction)
                {
                    Button(action: { presentAlert = true })
                    {
                        Image(systemName: "trash")
                            .foregroundStyle(.red)
                    }
                }
            }
        }
    }
    
    func deleteContact(at offsets: IndexSet)
    {
        for offset in offsets
        {
            // find this container in our query
            let contact = contacts[offset]

            // delete it from the context
            modelContext.delete(contact)
        }
    }
    
    func eraseData()
    {
        for contact in contacts
        {
            modelContext.delete(contact)
        }
        
        for keyPair in keyPairs
        {
            modelContext.delete(keyPair)
        }
    }
}

#Preview
{
    NavigationStack
    {
        HomeView()
    }
}
