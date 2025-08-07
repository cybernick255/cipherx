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
    @Query var contacts: [Contact]
    
    @State private var presentSheet: Bool = false
    
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(Constants().primaryColor)
                List(contacts)
                { contact in
                    NavigationLink(destination: ContactView(contact: contact))
                    {
                        Text(contact.name)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Contacts")
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
            }
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
