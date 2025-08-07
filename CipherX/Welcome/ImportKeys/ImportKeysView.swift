//
//  ImportKeysView.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/4/25.
//

import SwiftUI

struct ImportKeysView: View
{
    var body: some View
    {
        ZStack
        {
            Rectangle()
                .ignoresSafeArea()
                .foregroundStyle(Constants().primaryColor)
            
            Text("Import Keys")
                .foregroundStyle(Constants().secondaryColor)
        }
    }
}

#Preview
{
    ImportKeysView()
}
