//
//  BlockHeader.swift
//  SwiftChain
//
//  Created by Nick DiZazzo on 2018-05-04.
//  Copyright © 2018 Nick DiZazzo. All rights reserved.
//

import Foundation
import CryptoSwift

internal struct BlockHeader: Codable, Equatable {
    /// The index of this block
    var index: Int

    /// An incrementable 'number used once' when mining blocks
    var nonce: Int

    /// The difficulty this block is being mined at
    var difficulty: Int

    /// Overall hash value for this block
    var hashValue: String

    /// The hash value of the previous block
    var previousHash: String

    /// The hash value of the data contained in this block
    var dataHash: String = ""

    /// The time this block began being mined
    var time: TimeInterval = Date.timeIntervalSinceReferenceDate

    /// The combination of values this block's hash is computed using
    var key: String {
        return String(index) + String(nonce) + previousHash + dataHash + String(difficulty)
    }

    /// This method returns a key for the block, hashed using the provided hashing function.
    ///
    /// - Returns: A hash value corresponding to the values specified in the 'key' property.
    func computeHash(with algorithm: BlockHashAlgorithm) -> String {
        return algorithm.computed(for: key)
    }

    /// Initializer for creating a block's header, which contains metadata for each block.
    ///
    /// - Parameters:
    ///   - index: The sequential number of this block.
    ///   - previousHash: The hash value of the last block.
    ///   - difficulty: The difficulty this block is being mined at.
    ///   - timestamp: The time this block began being mined.
    public init(index: Int, previousHash: String, difficulty: Int, timestamp: TimeInterval) {
        self.difficulty = difficulty
        self.previousHash = previousHash
        self.index = index
        self.time = timestamp
        self.nonce = 0
        self.hashValue = ""
    }
}
