//
//  KeyPair.swift
//  CipherX
//
//  Created by Nicolas Deleasa on 8/5/25.
//

import Foundation
import CryptoKit

struct KeyPair
{
    let privateKey: P384.KeyAgreement.PrivateKey
    let publicKey: P384.KeyAgreement.PublicKey
}
