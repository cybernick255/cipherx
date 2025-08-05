//
//  GenerateKeysView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/4/25.
//

import SwiftUI

struct GenerateKeysView: View
{
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(primaryColor)
            
            Text("Generate Keys")
                .foregroundStyle(secondaryColor)
        }
    }
}

#Preview
{
    GenerateKeysView()
}
