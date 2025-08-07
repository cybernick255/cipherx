//
//  Contact.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/5/25.
//

import Foundation
import SwiftData

@Model
class Contact
{
    var name: String
    var publicKey: String
    
    init(name: String, publicKey: String)
    {
        self.name = name
        self.publicKey = publicKey
    }
}
