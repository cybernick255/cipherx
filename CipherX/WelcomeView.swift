//
//  WelcomeView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/4/25.
//

import SwiftUI

struct WelcomeView: View
{
    var body: some View
    {
        NavigationStack
        {
            ZStack
            {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(secondaryColor)
                
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
                                .fill(primaryColor)
                            )
                            .foregroundStyle(.white)
                    }
                    NavigationLink(destination: ImportKeysView())
                    {
                        Text("Import Keys")
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .fill(.clear)
                                .stroke(primaryColor)
                            )
                            .foregroundStyle(primaryColor)
                    }
                }
            }
        }
    }
}

#Preview
{
    WelcomeView()
}
