//
//  Block.swift
//  SwiftChain
//
//  Created by Nick DiZazzo on 2018-04-27.
//  Copyright © 2018 Nick DiZazzo. All rights reserved.
//

import Foundation

/// The `Block` object represents a container for encoded data in our block chain
public struct Block: Codable {
    static let defaultHash = String(repeating: "0", count: 64)

    /// A header object that contains metadata related to this block.
    internal(set) var header: BlockHeader

    /// Byte encoded data this block contains. Can be empty, if you really want.
    private(set) var data: Data?

    /// Constructor for making the next block in the chain, at a given difficulty.
    ///
    /// - Parameters:
    ///   - lastBlock: The block preceeding this one
    ///   - difficulty: The desired difficulty for this block
    ///   - data: The data this block should contain
    internal init(lastBlock: Block?, data: Data?, difficulty: Int) {
        let lastIndex = lastBlock?.header.index
        let lastHash = lastBlock?.header.hashValue

        let targetIndex = lastIndex != nil ? lastIndex! + 1 : 0

        self.data = data
        self.header = BlockHeader(index: targetIndex,
                                  previousHash: lastHash ?? Block.defaultHash,
                                  difficulty: difficulty,
                                  timestamp: Date.timeIntervalSinceReferenceDate)
    }

    /// An internal helper function used to simplify
    ///
    /// - Parameters:
    ///   - lastBlock: The last block added to the blockchain.
    ///   - data: The data to be added to the blockchain.
    ///   - difficulty: The difficulty level to mine the new block at.
    ///   - algorithm: Which algorithm to use when mining the block.
    /// - Returns: A new block with a hash computed that matches the provided data, as well as the last block.
    internal static func mine(using lastBlock: Block,
                              data: Data,
                              difficulty: Int,
                              using algorithm: BlockHashAlgorithm) -> Block {
        var block = Block(lastBlock: lastBlock, data: data, difficulty: difficulty)
        block.mine(at: difficulty, using: algorithm)
        return block
    }

    /// Begins mining this block with the current data object, as well as the existing header data.
    ///
    /// - Parameter difficulty: The difficulty the block must be mined at.
    internal mutating func mine(at difficulty: Int, using algorithm: BlockHashAlgorithm) {
        let difficultyPrefix = String(repeating: "0", count: difficulty)

        // Compute the hash for the data in this block
        if let data = self.data {
            self.header.dataHash = algorithm.computed(for: data)
        }

        // Hash the header values until one fits the current difficulty
        self.header.hashValue = self.header.computeHash(with: algorithm)
        while !self.header.hashValue.hasPrefix(difficultyPrefix) {
            self.header.nonce += 1
            self.header.hashValue = self.header.computeHash(with: algorithm)
        }
    }
}

extension Block: Equatable {
    public static func == (lhs: Block, rhs: Block) -> Bool {
        return lhs.header == rhs.header && lhs.data == rhs.data
    }
}
