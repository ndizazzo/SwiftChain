//
//  Blockchain.swift
//  SwiftChain
//
//  Created by Nick DiZazzo on 2018-04-27.
//  Copyright © 2018 Nick DiZazzo. All rights reserved.
//

import Foundation

/// The Blockchain class is responsible for providing the core functionality of allowing the storage of data, as well
/// as facilitating the computation of blocks and their hashes.
open class Blockchain: Codable {
    /// The approximate time (in seconds) we want this blockchain to allow blocks to be mined at.
    static var blockTime = 3.0

    /// The blocks contained within this blockchain.
    public var blocks: [Block] = []

    // How many blocks are contained within this blockchain.
    public var length: Int { return blocks.count }

    // Returns the last block contained in the blockchain.
    public var lastBlock: Block { return blocks.last! }

    /// A default 'genesis' block that can be used to create a blockchain.
    internal lazy var genesisBlock: Block = {
        var block = Block(lastBlock: nil, data: nil, difficulty: 0)
        block.mine(at: 0, using: hashingAlgorithm)
        return block
    }()

    /// A computed value for the current difficulty this blockchain is mining blocks at. This difficulty value
    /// progressivly ramps up to attempt to maintain block production at a constant rate.
    ///
    /// This value is derived using the 'blockTime' property, and should never be less than 0.
    public var currentDifficulty: Int {
        let now = Date.timeIntervalSinceReferenceDate
        let lastDifficulty = lastBlock.header.difficulty
        let lastBlockTime = lastBlock.header.time
        let maxTime = lastBlockTime + Blockchain.blockTime
        let newDifficulty = maxTime >= now ? lastDifficulty + 1 : lastDifficulty - 1

        return newDifficulty > 0 ? newDifficulty : 0
    }

    /// The selected hash algorithm for this blockchain
    internal var hashingAlgorithm: BlockHashAlgorithm = .sha256

    /// Allows the initiaization of a blockchain object with the provided data contained in the genesis block.
    ///
    /// - Parameter data: The data to include in the genesis block.
    public init(data: Data, algorithm: BlockHashAlgorithm) {
        self.hashingAlgorithm = algorithm

        var genesisBlock = Block(lastBlock: nil, data: data, difficulty: currentDifficulty)
        genesisBlock.mine(at: currentDifficulty, using: hashingAlgorithm)

        blocks.append(genesisBlock)
    }

    /// Allows the initialization of a blockchain object with no data contained in the genesis block.
    public init() {
        blocks.append(genesisBlock)
    }

    /// Instructs the blockchain class to add a block that contains the provided data.
    ///
    /// This method will block execution on the current thread until the mining process is completed.
    ///
    /// - Parameter data: The data the newly returned block should contain.
    /// - Returns: A successfully mined block object with a new hash value derived from previous blocks.
    public func addBlock(with data: Data) -> Block {
        let block = Block.mine(using: lastBlock, data: data, difficulty: currentDifficulty, using: hashingAlgorithm)
        blocks.append(block)
        return block
    }

    // This allows our blockchain to conform to 'Codable'
    internal enum CodingKeys: CodingKey {
        case blocks
    }
}

extension Blockchain: Comparable {
    public static func < (lhs: Blockchain, rhs: Blockchain) -> Bool {
        return lhs.blocks.count < rhs.blocks.count
    }

    public static func == (lhs: Blockchain, rhs: Blockchain) -> Bool {
        return lhs.blocks == rhs.blocks && lhs.currentDifficulty == rhs.currentDifficulty
    }
}
