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
    
    let options: [String] = ["Decrypt", "Encrypt"]
    
    @State private var presentSheetAddContact: Bool = false
    @State private var presentSheetSettings: Bool = false
    @State private var option: String = "Decrypt"
    
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
            .sheet(isPresented: $presentSheetAddContact)
            {
                AddContactView()
            }
            .sheet(isPresented: $presentSheetSettings)
            {
                SettingsView()
            }
            .toolbar
            {
                ToolbarItem(placement: .primaryAction)
                {
                    Button(action: { presentSheetAddContact = true })
                    {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .cancellationAction)
                {
                    Button(action: { presentSheetSettings = true })
                    {
                        Image(systemName: "gear")
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
}

#Preview
{
    NavigationStack
    {
        HomeView()
    }
}
