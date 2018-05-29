//
//  BlockhashAlgorithm.swift
//  SwiftChain
//
//  Created by Nick DiZazzo on 2018-05-09.
//  Copyright © 2018 TWG. All rights reserved.
//

import Foundation
import CryptoSwift

/// A selection of hash algorithms that can be computed for blocks.
public enum BlockHashAlgorithm {
    case md5
    case sha1
    case sha224, sha256, sha384, sha512
    case keccak224, keccak256, keccak384, keccak512

    func computed(for data: Data) -> String {
        switch self {
        case .md5: return data.md5().toHexString()
        case .sha1: return data.sha1().toHexString()
        case .sha224: return data.sha224().toHexString()
        case .sha256: return data.sha256().toHexString()
        case .sha384: return data.sha384().toHexString()
        case .sha512: return data.sha512().toHexString()
        case .keccak224: return data.sha3(.keccak224).toHexString()
        case .keccak256: return data.sha3(.keccak256).toHexString()
        case .keccak384: return data.sha3(.keccak384).toHexString()
        case .keccak512: return data.sha3(.keccak512).toHexString()
        }
    }

    func computed(for key: String) -> String {
        switch self {
        case .md5: return key.md5()
        case .sha1: return key.sha1()
        case .sha224: return key.sha224()
        case .sha256: return key.sha256()
        case .sha384: return key.sha384()
        case .sha512: return key.sha512()
        case .keccak224: return key.sha3(.keccak224)
        case .keccak256: return key.sha3(.keccak256)
        case .keccak384: return key.sha3(.keccak384)
        case .keccak512: return key.sha3(.keccak512)
        }
    }
}
