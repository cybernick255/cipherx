//
//  WelcomeView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/4/25.
//

import SwiftUI

struct WelcomeView: View
{
    @AppStorage("returningUser-1_1_0") private var returningUser110: Bool = false
    
    @State private var presentUpdateSheet: Bool = false
    
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
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                    
                    NavigationLink(destination: GenerateKeysView())
                    {
                        Text("Generate Keys")
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .fill(Constants().secondaryColor)
                            )
                            .foregroundStyle(.white)
                    }
                    NavigationLink(destination: ImportKeysView())
                    {
                        Text("Import Keys")
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .fill(.clear)
                                .stroke(Constants().secondaryColor)
                            )
                            .foregroundStyle(Constants().secondaryColor)
                    }
                }
            }
            .onAppear
            {
                presentUpdateSheet = !returningUser110
            }
            .sheet(isPresented: $presentUpdateSheet)
            {
                UpdateMessageView()
                    .onAppear
                    {
                        returningUser110 = true
                    }
            }
        }
    }
}

#Preview
{
    WelcomeView()
}
