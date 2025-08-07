//
//  Contact.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/5/25.
//

import Foundation
import CryptoKit

struct Contact
{
    var name: String
    var publicKey: P384.KeyAgreement.PublicKey
}
