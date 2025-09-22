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

extension Contact
{
    static let sample = Contact(
        name: "Alice Example",
        publicKey: "LnEzISA4b+5YkD41YMKd+PUbDlDQLk5aFQ9H47LuoAv4avFM9EHqbl/vFC4j+qEwzpjbMdZPyp9qaFNG0QSYMgHdErqaL+CrqwzZ8NM2OMaD7J2+hjRb1VAbExMgnrZO"
    )
}
